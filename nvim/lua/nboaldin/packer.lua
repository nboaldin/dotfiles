-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    config = function() require("telescope").setup() end,
    requires = { { 'nvim-lua/plenary.nvim' } },
  }

  use { 'sainnhe/gruvbox-material',
    as = 'gruvbox-material',
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use('mbbill/undotree')

  use { 'akinsho/bufferline.nvim',
    tag = "*",
    config = function() require("bufferline").setup() end
  }

  use {
    'nvim-tree/nvim-tree.lua',
    config = function() require("nvim-tree").setup() end
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }

  use {
    "jay-babu/mason-null-ls.nvim",
    requires = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    }
  }

  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end
  }

  use { "akinsho/toggleterm.nvim", tag = '*',
    config = function() require("toggleterm").setup() end
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

end)

