return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			on_attach = "default",
			disable_netrw = true,
			hijack_netrw = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			renderer = {
				root_folder_modifier = ":t",
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							arrow_open = "",
							arrow_closed = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							untracked = "U",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			view = {
				width = 30,
				side = "right",
				-- mappings = {
				--   list = {
				--     { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },                                               --     { key = "h",                  cb = tree_cb "close_node" },
				--     { key = "v",                  cb = tree_cb "vsplit" },
				--   },
				-- },
			},
		})

		-- Simple solution for alternative of `Auto Close` option
		vim.api.nvim_create_autocmd({ "QuitPre" }, {
			callback = function()
				vim.cmd("NvimTreeClose")
			end,
		})

		local api = require("nvim-tree.api")

		vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<Return>", { silent = true })
		vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFileToggle<Return>", { silent = true })
		vim.keymap.set("n", "<leader>ec", ":NvimTreeCollapse<Return>", { silent = true })
		vim.keymap.set("n", "<leader>er", ":NvimTreeRefresh<Return>", { silent = true })
		vim.keymap.set("n", "<leader>egi", api.tree.toggle_gitignore_filter, {})
	end,
}
