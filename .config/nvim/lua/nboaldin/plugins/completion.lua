-- blink.cmp replaces nvim-cmp + cmp-nvim-lsp + cmp-buffer + LuaSnip + cmp_luasnip.
-- Snippets use Neovim's native vim.snippet, so <Tab> jumping works for them.
return {
    {
        "saghen/blink.cmp",
        version = "1.*", -- prebuilt fuzzy-matcher binaries, no Rust toolchain needed
        event = "InsertEnter",
        opts = {
            -- Same bindings as the old nvim-cmp setup
            keymap = {
                preset = "none",
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<CR>"] = { "select_and_accept", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            },
            completion = {
                -- nothing preselected: <Tab> picks the first item, <CR> accepts the first item
                list = { selection = { preselect = false, auto_insert = false } },
                menu = {
                    border = "rounded",
                    draw = {
                        columns = { { "label", "label_description", gap = 1 }, { "source_name" }, { "kind" } },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = "rounded" },
                },
            },
            signature = { window = { border = "rounded" } },
            sources = { default = { "lsp", "snippets", "buffer" } },
        },
    },
}
