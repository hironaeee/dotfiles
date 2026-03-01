return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter_path = vim.fs.joinpath(vim.fn.stdpath("data"), "/treesitter")
		vim.uv.fs_mkdir(treesitter_path, tonumber("755", 8))

		local nvim_treesitter = require("nvim-treesitter")

		nvim_treesitter.setup({
			install_dir = treesitter_path,
		})
		nvim_treesitter
			.install({
				"tsx",
				"lua",
				"json",
				"css",
				"go",
			})
			:wait(300000) -- max wait time of 5 minutes

		-- enable highlighting automatically
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
			callback = function(_)
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
