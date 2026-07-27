local wezterm = require("wezterm")

local config = wezterm.config_builder()

local function read_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil
	end
	local content = file:read("a")
	file:close()
	return content
end

local function source_if_exists(filename)
	local path = wezterm.config_dir .. "/" .. filename
	if not read_file(path) then
		return
	end

	local ok, err = pcall(function()
		dofile(path)(config)
	end)
	if not ok then
		wezterm.log_error("Failed to load " .. path .. ": " .. tostring(err))
	end
end

config.audible_bell = "Disabled"
config.warn_about_missing_glyphs = false

config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.font = wezterm.font_with_fallback({
	"Mononoki Nerd Font",
	"PlemolJP",
})
config.line_height = 1.3

local is_mac = wezterm.target_triple:find("apple") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local is_win = wezterm.target_triple:find("windows") ~= nil
-- blur
if is_mac then
	config.window_background_opacity = 0.8
	config.macos_window_background_blur = 50
elseif is_win then
	config.window_background_opacity = 0.7
	config.win32_system_backdrop = "Acrylic"
end
-- pywal16
if is_mac or is_linux then
	local home = os.getenv("HOME")
	if home then
		local wal_colors_path = home .. "/.cache/wal/colors-wezterm.toml"
		if read_file(wal_colors_path) then
			local wal_colors = wezterm.color.load_scheme(wal_colors_path)
			config.colors = wal_colors
		end
	end
end
-- Windows specific config
if is_win then
	source_if_exists("wezterm_win.lua")
end

source_if_exists("local.lua")

return config
