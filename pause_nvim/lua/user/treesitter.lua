local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {"rust", "go", "markdown", "javascript", "terraform", "json", "lua", "toml", "yaml", "css", "bash", "vue", "vim", "kdl"}, -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	autopairs = {
		enable = true,
	},
	indent = { 
    enable = true,
  },
})