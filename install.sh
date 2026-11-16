#!/usr/bin/env bash
# Symlink this repo into $HOME. Works on macOS and Linux, safe to re-run.
#
#   ./install.sh              link everything, skip anything that would be overwritten
#   ./install.sh -n           dry run, show what would happen
#   ./install.sh -f           back up conflicting files to <name>.bak.<timestamp> and link
#
# Existing links that already point into this repo are left alone, so it does
# not matter whether they were created relative or absolute.

set -u

DRY=0
FORCE=0
for arg in "$@"; do
  case $arg in
    -n|--dry-run) DRY=1 ;;
    -f|--force)   FORCE=1 ;;
    -h|--help)    sed -n '2,10p' "$0"; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

OS=$(uname -s)   # Darwin or Linux
STAMP=$(date +%Y%m%d%H%M%S)

# Files linked straight into $HOME.
HOME_FILES=(.zshrc .zprofile .zsh .tmux.conf install.sh)

# ~/.config dirs that applications also write into (node_modules, lockfiles, ...).
# Link their files one by one instead of replacing the whole directory.
PER_FILE_DIRS=(lazygit)

linked=0 ok=0 skipped=0

say() { printf '%-8s %s\n' "$1" "$2"; }

# Physical path of $1 with symlinks resolved (works on macOS, no readlink -f).
resolve() {
  local p=$1 t
  # follow symlinks (relative or absolute) down to the real path
  while [ -L "$p" ]; do
    t=$(readlink "$p")
    case $t in /*) p=$t ;; *) p=$(dirname "$p")/$t ;; esac
  done
  if [ -d "$p" ]; then (cd -P "$p" && pwd -P)
  else (cd -P "$(dirname "$p")" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$(basename "$p")")
  fi
}

# Repo root, found through any symlink to this script (e.g. ~/install.sh).
REPO=$(dirname "$(resolve "$0")")

# link SRC DEST: make DEST a symlink to SRC.
link() {
  local src=$1 dest=$2

  if [ -L "$dest" ] && [ "$(resolve "$dest")" = "$(resolve "$src")" ]; then
    say ok "$dest"; ok=$((ok + 1)); return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ -f "$dest" ] && [ ! -L "$dest" ] && [ ! -s "$dest" ]; then
      # empty regular file, nothing to lose
      say empty "$dest (replacing)"
      [ $DRY -eq 1 ] || rm "$dest"
    elif [ $FORCE -eq 1 ]; then
      say backup "$dest -> $dest.bak.$STAMP"
      [ $DRY -eq 1 ] || mv "$dest" "$dest.bak.$STAMP"
    else
      say SKIP "$dest exists and is not a link to this repo (use -f to back it up and replace)"
      skipped=$((skipped + 1)); return
    fi
  fi

  say link "$dest -> $src"
  if [ $DRY -eq 0 ]; then
    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
  fi
  linked=$((linked + 1))
}

in_list() { local x=$1; shift; for i in "$@"; do [ "$i" = "$x" ] && return 0; done; return 1; }

echo "repo: $REPO ($OS)"
[ $DRY -eq 1 ] && echo "dry run, nothing will be changed"

# Home-level files.
for f in "${HOME_FILES[@]}"; do
  link "$REPO/$f" "$HOME/$f"
done

# ~/.config/*, discovered from the repo so new tools are picked up automatically.
for src in "$REPO"/.config/*; do
  [ -e "$src" ] || continue
  name=$(basename "$src")
  if in_list "$name" "${PER_FILE_DIRS[@]}" && [ -d "$src" ]; then
    for file in "$src"/*; do
      [ -e "$file" ] || continue
      link "$file" "$HOME/.config/$name/$(basename "$file")"
    done
  else
    link "$src" "$HOME/.config/$name"
  fi
done

# Alacritty can't branch on OS, so alacritty.toml imports ~/.config/alacritty/local.toml
# and each OS points that at its own file (darwin.toml / linux.toml).
case $OS in
  Darwin) ALAC=darwin.toml ;;
  Linux)  ALAC=linux.toml ;;
  *)      ALAC= ;;
esac
if [ -n "$ALAC" ] && [ -f "$REPO/.config/alacritty/$ALAC" ]; then
  link "$REPO/.config/alacritty/$ALAC" "$REPO/.config/alacritty/local.toml"
fi

echo
echo "linked $linked, already ok $ok, skipped $skipped"
# Conflicts are reported, not fatal: re-running never changes anything it already did.
exit 0
