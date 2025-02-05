require("telescope").setup({
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
