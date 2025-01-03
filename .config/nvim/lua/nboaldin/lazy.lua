local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {

	{
		"nvim-telescope/telescope.nvim",
		-- version = "0.1.1",
		config = true,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "echasnovski/mini.nvim", version = "*" },
	{ "glepnir/zephyr-nvim", name = "zephyr" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
	"mbbill/undotree",
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "*",
	-- 	config = true,
	-- },
	{
		"nvim-lualine/lualine.nvim",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig", -- Required
			-- Optional
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim", -- Optional

			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- Copilot
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup({
						suggestion = { enabled = false },
						panel = { enabled = false },
					})
				end,
			},

			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
	},
	"stevearc/conform.nvim",
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	-- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	-- "leoluz/nvim-dap-go",
}

require("lazy").setup(plugins, {})
