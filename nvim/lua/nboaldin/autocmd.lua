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
