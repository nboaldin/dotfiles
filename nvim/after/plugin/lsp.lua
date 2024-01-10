local lsp = require("lsp-zero")
local formatter = require("formatter")

lsp.preset("recommended")

-- lsp.ensure_installed({
--   "gopls",
--   "jsonls",
--   "marksman",
--   "rust_analyzer",
--   "terraformls",
--   "vuels",
--   "lua_ls",
--   "tsserver",
-- })

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  },
})

lsp.on_attach(function(client, bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true}) <cr> :FormatWrite <cr>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end)

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { "gopls",
    "jsonls",
    "marksman",
    "rust_analyzer",
    "terraformls",
    "vuels",
    "lua_ls",
    "tsserver",
  },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

lsp.setup()

-- These are not auto installed so must be installed... currently installations happen via Mason
-- Utilities for creating configurations

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,
    },
    sh = {
      require("formatter.filetypes.sh").shfmt,
    },

    markdown = {
      require("formatter.filetypes.markdown").prettierd,
    },
    html = {
      require("formatter.filetypes.html").prettierd,
    },
    json = {
      require("formatter.filetypes.json").prettierd,
    },
    yaml = {
      require("formatter.filetypes.yaml").prettierd,
    },
    css = {
      require("formatter.filetypes.css").prettierd,
    },
    terraform = {
      require("formatter.filetypes.terraform").terraformfmt,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    -- ["*"] = {
    --   -- "formatter.filetypes.any" defines default configurations for any
    --   -- filetype
    --   require("formatter.filetypes.any").remove_trailing_whitespace,
    -- },
  },
})

-- Null ls was using prettier for lots of files, shellcheck and beauty sh for shell,

-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/integrate-with-null-ls.md
-- local null_ls = require('null-ls')
--
-- null_ls.setup({
--   sources = {
--     -- Replace these with the tools you want to install
--     -- make sure the source name is supported by null-ls
--     -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
--     null_ls.builtins.formatting.prettier,
--     null_ls.builtins.diagnostics.shellcheck,
--     null_ls.builtins.formatting.beautysh,
--     null_ls.builtins.diagnostics.codespell,
--   }
-- })
--
-- -- See mason-null-ls.nvim's documentation for more details:
-- -- https://github.com/jay-babu/mason-null-ls.nvim#setup
-- require('mason-null-ls').setup({
--   ensure_installed = nil,
--   automatic_installation = true,
-- })
--
-- vim.diagnostic.config({
--   virtual_text = true
-- })
--
-- vim.diagnostic.config({
--   virtual_text = true
-- })
