-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use({
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.1",
    config = function()
      require("telescope").setup()
    end,
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use({ "sainnhe/everforest", as = "everforest" })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  use("mbbill/undotree")

  use({
    "akinsho/bufferline.nvim",
    tag = "*",
    config = function()
      require("bufferline").setup()
    end,
  })


  use({
    "nvim-neo-tree/neo-tree.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  })


  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        -- Optional
        "williamboman/mason.nvim",
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  })

  use({
    "stevearc/conform.nvistevearc/conform.nvimm",
  })

  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use({
    "leoluz/nvim-dap-go"
  })



  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("toggleterm").setup()
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  })

  -- use("github/copilot.vim")

  use({
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({})
    end,
  })
end)
