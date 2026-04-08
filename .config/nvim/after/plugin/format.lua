require("conform").setup({
    -- Map of filetype to formatters
    formatters_by_ft = {
        terraform = { "terraform_fmt" },
        sh = { "shfmt" },
        markdown = { "prettier" },
        html = { "prettier" },
        -- json = { "prettierd" },
        css = { "prettier" },
        yaml = { "prettier" },
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        go = { "goimports", "gofmt" },
        -- Use a sub-list to run only the first available formatter
        javascript = function(bufnr)
            if require("conform").get_formatter_info("eslint", bufnr).available then
                return { "eslint" }
            else
                return { "prettier" }
            end
        end,
        typescript = function(bufnr)
            if require("conform").get_formatter_info("eslint", bufnr).available then
                return { "eslint" }
            else
                return { "prettier" }
            end
        end,
        -- You can use a function here to determine the formatters dynamically
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
    },
    -- Set this to change the default values when calling conform.format()
    -- This will also affect the default values for format_on_save/format_after_save
    default_format_opts = {
        lsp_format = "prefer",
    },
    -- If this is set, Conform will run the formatter on save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    async = true,
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end

        return {
            -- I recommend these options. See :help conform.format for details.
            lsp_format = "prefer",
            -- This should be ignored since async true is set
            timeout_ms = 500,
        }
    end,
    -- If this is set, Conform will run the formatter asynchronously after save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
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
