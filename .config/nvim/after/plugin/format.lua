require("conform").setup({
    -- Map of filetype to formatters
    formatters_by_ft = {
        terraform = { "terraform_fmt" },
        sh = { "shfmt" },
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        go = { "goimports", "gofmt" },

        -- JS/TS ecosystem: different projects use prettier, eslint, or both.
        -- stop_after_first tries each in order and uses whichever is actually
        -- available (executable found) for THIS project - prettierd/prettier
        -- win when present (most common), eslint_d is used as a formatter
        -- when a project only has ESLint configured. If none of these are
        -- installed, lsp_format = "fallback" (below) uses the attached LSP
        -- (ts_ls/eslint) to format instead.
        javascript = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
        typescript = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },

        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return {
            lsp_format = "fallback",
            timeout_ms = 500,
        }
    end,
    log_level = vim.log.levels.ERROR,
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Custom formatters and changes to built-in formatters
})

vim.api.nvim_create_user_command("FormatDisable", function(opts)
    if opts.bang then
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })
