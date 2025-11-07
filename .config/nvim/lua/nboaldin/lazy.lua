-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
local plugins = {

    {
        "nvim-telescope/telescope.nvim",
        -- version = "0.1.1",
        config = true,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "tpope/vim-fugitive" },
    { "echasnovski/mini.nvim",           version = "*" },
    { "glepnir/zephyr-nvim",             name = "zephyr" },
    { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
    { "mbbill/undotree" },
    {
        "nvim-lualine/lualine.nvim",
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "L3MON4D3/LuaSnip" },
    { "stevearc/conform.nvim" },
    {
        "mfussenegger/nvim-lint",
        config = function()
            -- Instead of specifying filetypes, use an autocommand to lint with codespell for any filetype
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
                callback = function()
                    -- Run codespell for the current buffer's filetype
                    require("lint").try_lint("codespell")
                end,
            })
        end,
    },
    {
        "numToStr/Comment.nvim",
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        config = true,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "github/copilot.vim"
    },
}

require("lazy").setup({
    spec = plugins
})
