return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4048" })
		vim.api.nvim_set_hl(0, "IblScope", { fg = "#556b2f" })

		require("ibl").setup({
			indent = {
				highlight = "IblIndent",
				char = "│",
			},
			scope = {
				highlight = "IblScope",
				show_start = false,
				show_end = false,
			},
		})
	end,
}
