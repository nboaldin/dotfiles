local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})
--
-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "nvim-lua/plenary.nvim"}) -- Useful lua functions used by l
  use({ "windwp/nvim-autopairs"}) -- Autopairs, integrates with both cmp and treesitter
  use({ "numToStr/Comment.nvim"})
  use({ "JoosepAlviste/nvim-ts-context-commentstring"})
  use({ "akinsho/bufferline.nvim"})
  use({ "moll/vim-bbye"})
  use({ "nvim-lualine/lualine.nvim"})
  use({ "akinsho/toggleterm.nvim"})
  use({ "ahmedkhalf/project.nvim"})
  use({ "lewis6991/impatient.nvim"})
  use({ "lukas-reineke/indent-blankline.nvim"})

  --nvim tree
  use({ "kyazdani42/nvim-tree.lua" })

  -- Colorschemes
  --[[ use({ "folke/tokyonight.nvim"}) ]]
  --[[ use({ "lunarvim/darkplus.nvim"}) ]]
  use({ "sainnhe/gruvbox-material"})
  --[[ use({ "rose-pine/neovim", as = "rose-pine", tag = "v1.*" }) ]]
  --[[ use({ "shaunsingh/nord.nvim"}) ]]


  -- cmp plugins
  use({ "hrsh7th/nvim-cmp"}) -- The completion plugin
  use({ "hrsh7th/cmp-buffer"}) -- buffer completions
  use({ "hrsh7th/cmp-path"}) -- path completions
  use({ "saadparwaiz1/cmp_luasnip"}) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lsp"})
  use({ "hrsh7th/cmp-nvim-lua"})

  -- snippets
  use({ "L3MON4D3/LuaSnip"}) --snippet engine
  use({ "rafamadriz/friendly-snippets"}) -- a bunch of snippets to use

  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "neovim/nvim-lspconfig",
  })

  use({ "RRethy/vim-illuminate"})

  -- Telescope
  use({ "nvim-telescope/telescope.nvim"})

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- DAP
  use({ "mfussenegger/nvim-dap"})
  use({ "rcarriga/nvim-dap-ui"})
  use({ "ravenxrz/DAPInstall.nvim"})

  -- Whitespace
  use({ "ntpeters/vim-better-whitespace" })

  vim.g.better_whitespace_ctermcolor = "gray"
  vim.g.better_whitespace_guicolor = "gray"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
