require("options")
require("keymaps")
if vim.fn.has("gui_running") == 0 then
	require("plugin")
end

---@param num number | string | boolean | nil
---@return boolean
local function to_bool(num)
	if num == 0 or num == "" or num == false or num == nil then
		return false
	end
	return true
end

if to_bool(vim.fn.filereadable(vim.fn.expand("~/.config/nvim/lua/local.lua"))) then
	require("local")
end
