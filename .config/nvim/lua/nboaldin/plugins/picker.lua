-- fzf-lua replaces telescope (fzf + fd/rg, much faster on big repos).
return {
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        opts = {
            files = { hidden = true },
            -- hidden files yes, but never .git/ (same as the old telescope ignore pattern)
            grep = {
                hidden = true,
                rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --glob=!.git/ -e",
            },
        },
        keys = {
            { "<leader>tt", "<cmd>FzfLua builtin<cr>",     desc = "Pickers" },
            { "<leader>ff", "<cmd>FzfLua files<cr>",       desc = "Find files" },
            { "<leader>ft", "<cmd>FzfLua live_grep<cr>",   desc = "Live grep" },
            { "<leader>fs", "<cmd>FzfLua grep_cword<cr>",  desc = "Grep word" },
            { "<leader>gf", "<cmd>FzfLua git_files<cr>",   desc = "Git files" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>",     desc = "Buffers" },
        },
    },
}
