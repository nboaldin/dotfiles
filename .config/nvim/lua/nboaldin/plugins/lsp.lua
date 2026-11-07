return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
            { "mason-org/mason-lspconfig.nvim", opts = {} },
            "saghen/blink.cmp",
        },
        config = function()
            -- Use rounded borders globally for all floating windows
            vim.o.winborder = "rounded"

            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- Features that only work if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
                    end

                    map("n", "K", vim.lsp.buf.hover, "LSP hover")
                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
                    map("n", "gr", vim.lsp.buf.references, "References")
                    map("n", "gs", vim.lsp.buf.signature_help, "Signature help")
                    map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
                    map("n", "<leader>de", function()
                        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
                        vim.schedule(function()
                            vim.diagnostic.open_float(nil, {
                                scope = "line",
                                focus = false,
                                severity = vim.diagnostic.severity.ERROR,
                            })
                        end)
                    end, "Next error")
                    -- :LspInfo was removed from nvim-lspconfig; :checkhealth vim.lsp is the replacement
                    map("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>", "LSP info")
                    map("n", "<F2>", vim.lsp.buf.rename, "Rename")
                    map({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, "LSP format")
                    map("n", "<F4>", vim.lsp.buf.code_action, "Code action")
                end,
            })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = { vim.env.VIMRUNTIME } },
                    },
                },
            })

            vim.lsp.config("eslint", {
                settings = {
                    codeAction = {
                        disableRuleComment = { enable = true, location = "separateLine" },
                        showDocumentation = { enable = true },
                    },
                    codeActionOnSave = { enable = true, mode = "all" },
                    format = true,
                    nodePath = "",
                    onIgnoredFiles = "off",
                    packageManager = "npm",
                    quiet = false,
                    rulesCustomizations = {},
                    run = "onType",
                    useESLintClass = false,
                    validate = "on",
                    workingDirectory = { mode = "location" },
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
        end,
    },
}
