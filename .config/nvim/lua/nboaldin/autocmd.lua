-- Open mini.files only when nvim is started with no file arguments
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        if vim.fn.argc() == 0 then
            require("mini.files").open()
        end
    end,
})



-- vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
-- vim.cmd([[autocmd BufWritePre * FormatWrite]])

-- vim.cmd([[
--      augroup Formatting
--        autocmd!
--        autocmd BufWritePre * lua vim.lsp.buf.format()
--        " autocmd BufWritePre * FormatWrite
--      augroup END
--      do Formatting
--    ]])
