local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.handlers").setup()

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "gopls", "jsonls", "marksman", "rust_analyzer", "terraformls", "vuels", "lua_ls"
  }
})
require("mason-lspconfig").setup_handlers {
  function(server_name)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }

    local require_ok, server = pcall(require, "user.lsp.settings." .. server_name)
    if require_ok then
      opts = vim.tbl_deep_extend("force", server, opts)
    end

    lspconfig[server_name].setup(opts)
  end,
}

require("mason").setup()
require("mason-null-ls").setup({
    ensure_installed = {
    "prettier", "shellcheck", "beautysh"
    },
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
    handlers = {},
})
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.zsh
    }
})

--[[ require("mason-null-ls").setup({ ]]
--[[   ensure_installed = { ]]
--[[     "prettier", "shellcheck", "beautysh" ]]
--[[   }, ]]
--[[   automatic_installation = false, ]]
--[[   automatic_setup = true, -- Recommended, but optional ]]
--[[ }) ]]
--[[ require("null-ls").setup({ ]]
--[[   on_attach = require("user.lsp.handlers").on_attach, ]]
--[[   capabilities = require("user.lsp.handlers").capabilities, ]]
--[[ }) ]]
--[[ require 'mason-null-ls'.setup_handlers() ]]
