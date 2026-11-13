# Fast nvm: put the default Node on PATH directly (a file read, no fork) and
# only source the slow nvm.sh the first time the `nvm` command is used.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

_nvm_sh=
for _f in "$NVM_DIR/nvm.sh" /usr/share/nvm/init-nvm.sh; do
  [[ -s $_f ]] && { _nvm_sh=$_f; break; }
done

if [[ -n $_nvm_sh ]]; then
  # resolve the default alias (e.g. "24" or "v22.13.1") to an installed version
  _nvm_alias=
  [[ -r $NVM_DIR/alias/default ]] && _nvm_alias=$(<$NVM_DIR/alias/default)
  _nvm_alias=${_nvm_alias//[[:space:]]/}
  _nvm_bin=
  if [[ $_nvm_alias == (v|)[0-9]* ]]; then
    _nvm_match=( $NVM_DIR/versions/node/v${_nvm_alias#v}*(NOn[1]) )
    [[ -n $_nvm_match ]] && _nvm_bin=$_nvm_match[1]/bin
  fi
  # fall back to the newest installed version
  if [[ -z $_nvm_bin ]]; then
    _nvm_match=( $NVM_DIR/versions/node/v*(NOn[1]) )
    [[ -n $_nvm_match ]] && _nvm_bin=$_nvm_match[1]/bin
  fi
  [[ -d $_nvm_bin ]] && path=( $_nvm_bin $path )

  nvm() {
    unfunction nvm
    source "$_nvm_sh"
    nvm "$@"
  }
fi
unset _f _nvm_alias _nvm_bin _nvm_match
