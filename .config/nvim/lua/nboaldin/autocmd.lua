vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.api.nvim_win_set_width(0, 120)
        require("telescope.builtin").find_files()
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
