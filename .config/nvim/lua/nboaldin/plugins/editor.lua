return {
    {
        -- mini.files (explorer) + mini.pairs (replaces nvim-autopairs)
        "echasnovski/mini.nvim",
        version = "*",
        event = "InsertEnter",
        keys = {
            { "<leader>e", function() require("mini.files").open() end, desc = "File explorer" },
        },
        config = function()
            require("mini.files").setup({ options = { use_as_default_explorer = false } })
            require("mini.pairs").setup()
        end,
    },
    {
        -- Neovim's built-in undotree (replaces mbbill/undotree)
        "nvim.undotree",
        virtual = true,
        keys = {
            {
                "<leader>u",
                function()
                    vim.cmd.packadd("nvim.undotree")
                    require("undotree").open()
                end,
                desc = "Undo tree",
            },
        },
    },
    {
        "tpope/vim-fugitive",
        cmd = {
            "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "Glgrep",
            "GMove", "GRename", "GDelete", "GRemove", "GBrowse", "Gedit", "Gsplit", "Gvsplit", "Gtabedit",
        },
    },
}
