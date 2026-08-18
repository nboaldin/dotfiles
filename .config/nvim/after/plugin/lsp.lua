local cmp = require("cmp")

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
            local n = entry.source.name
            if n == "nvim_lsp" then
                item.menu = "[LSP]"
            else
                item.menu = string.format("[%s]", n)
            end
            return item
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
})

-- Use rounded borders globally for all LSP floating windows
vim.o.winborder = "rounded"

vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
        vim.keymap.set("n", "<leader>de", function()
            vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
            vim.schedule(function()
                vim.diagnostic.open_float(nil, {
                    scope = "line",
                    focus = false,
                    severity = vim.diagnostic.severity.ERROR,
                })
            end)
        end, opts)
        vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = { vim.env.VIMRUNTIME },
            },
        },
    },
})

vim.lsp.config("eslint", {
    settings = {
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine",
            },
            showDocumentation = {
                enable = true,
            },
        },
        codeActionOnSave = {
            enable = true,
            mode = "all",
        },
        format = true,
        nodePath = "",
        onIgnoredFiles = "off",
        packageManager = "npm",
        quiet = false,
        rulesCustomizations = {},
        run = "onType",
        useESLintClass = false,
        validate = "on",
        workingDirectory = {
            mode = "location",
        },
    },
})

vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    root_markers = {
        { "tsconfig.json", "jsconfig.json" },
        "package.json",
        ".git",
    },
    workspace_required = true,
})

require("mason").setup({})
require("mason-lspconfig").setup({})
