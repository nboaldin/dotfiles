require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "^%.git/" } -- Ignores .git/ but not .github/
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        grep_string = {
            additional_args = { "--hidden" },
        },
        live_grep = {
            additional_args = { "--hidden" },
        },
    },
})
