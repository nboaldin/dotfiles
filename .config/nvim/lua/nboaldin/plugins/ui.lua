return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                always_divide_middle = false,
                globalstatus = false,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {
                    {
                        "buffers",
                        symbols = { modified = " *", alternate_file = "", directory = "" },
                    },
                },
                lualine_c = { "branch" },
                lualine_x = {
                    {
                        "filename",
                        file_status = true,
                        newfile_status = false,
                        path = 1, -- relative path
                        shorting_target = 40,
                        symbols = { modified = "[+]", readonly = "[-]", unnamed = "[No Name]", newfile = "[New]" },
                    },
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_c = { "filename" },
                lualine_x = { "location" },
            },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                local function map(lhs, rhs, desc)
                    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
                end
                -- NOTE: no <leader>h* maps, they would delay the <leader>h (nohlsearch) map
                map("]h", function() gs.nav_hunk("next") end, "Next hunk")
                map("[h", function() gs.nav_hunk("prev") end, "Previous hunk")
                map("<leader>gp", gs.preview_hunk, "Preview hunk")
                map("<leader>gs", gs.stage_hunk, "Stage/unstage hunk")
                map("<leader>gr", gs.reset_hunk, "Reset hunk")
                map("<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
            end,
        },
    },
}
