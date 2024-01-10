vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
vim.cmd([[autocmd BufWritePre * FormatWrite]])
