return {
	"Wansmer/symbol-usage.nvim",
	event = "BufReadPre",
	config = function()
		local SymbolKind = vim.lsp.protocol.SymbolKind
		require("symbol-usage").setup({
			kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Property },
		})
	end,
}
