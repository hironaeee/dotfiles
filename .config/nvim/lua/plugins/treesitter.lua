return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			highlight = {
				enable = true,
				disable = {},
			},
			indent = {
				enable = true,
				disable = {},
			},
			ensure_installed = {
				"tsx",
				"lua",
				"json",
				"css",
				"go",
			},
			diagnostics = {
				disable = { "missing-fields" },
			},
		})
	end,
}
