require("conform").setup({
	-- Map of filetype to formatters
	formatters_by_ft = {
		terraform = { "terraform_fmt" },
		sh = { "shfmt" },
		markdown = { "prettier" },
		html = { "prettier" },
		-- json = { "prettierd" },
		css = { "prettier" },
		yaml = { "prettier" },
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		go = { "goimports", "gofmt" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "prettier" },
		typescript = { "prettier" },
		-- You can use a function here to determine the formatters dynamically
		-- Use the "*" filetype to run formatters on all filetypes.
		["*"] = { "codespell" },
		-- Use the "_" filetype to run formatters on filetypes that don't
		-- have other formatters configured.
		["_"] = { "trim_whitespace" },
	},
	-- If this is set, Conform will run the formatter on save.
	-- It will pass the table to conform.format().
	-- This can also be a function that returns the table.
	format_on_save = {
		-- I recommend these options. See :help conform.format for details.
		lsp_fallback = true,
		timeout_ms = 500,
	},
	-- If this is set, Conform will run the formatter asynchronously after save.
	-- It will pass the table to conform.format().
	-- This can also be a function that returns the table.
	format_after_save = {
		lsp_fallback = true,
	},
	-- Set the log level. Use `:ConformInfo` to see the location of the log file.
	log_level = vim.log.levels.ERROR,
	-- Conform will notify you when a formatter errors
	notify_on_error = true,
	-- Custom formatters and changes to built-in formatters
})
