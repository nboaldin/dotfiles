local parsers = {
    "cmake", "json", "javascript", "typescript", "go", "rust", "bash", "vue",
    "markdown", "markdown_inline", "c", "lua", "vim", "vimdoc", "query", "swift",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false, -- the main branch does not support lazy-loading
        build = ":TSUpdate",
        config = function()
            -- Installs only the missing parsers (async, needs the tree-sitter CLI)
            require("nvim-treesitter").install(parsers)

            -- The main branch does not enable highlighting by itself
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    if pcall(vim.treesitter.start, args.buf) then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },
}
