local wezterm = require("wezterm")

local config = wezterm.config_builder()

local os_type = function()
	local env_home = os.getenv("HOME") or os.getenv("USERPROFILE") or ""
	if string.find(env_home, "/") then
		local os_name = io.popen("uname -s", "r"):read("*l"):lower()
		if os_name == "darwin" then
			return "mac"
		else
			return "unix"
		end
	elseif string.find(env_home, "\\") then
		return "win"
	else
		return ""
	end
end

local is_mac = os_type() == "mac"
local is_unix = os_type() == "unix"
local is_win = os_type() == "win"

config.audible_bell = "Disabled"

config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

if is_mac then
	config.window_background_opacity = 0.8
	config.macos_window_background_blur = 50
elseif is_win then
	config.default_prog = { "pwsh.exe" }

	config.window_background_opacity = 0.7
	config.win32_system_backdrop = "Acrylic"

	-- multiplecer like tmux
	config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
	config.keys = {
		-- split the window vertically
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- split the window horizontally
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		-- move between windows
		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		-- open a new tab
		{
			key = "c",
			mods = "LEADER",
			action = wezterm.action.SpawnTab("DefaultDomain"),
		},
		-- close a tab
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
		},
		-- move the next tab
		{
			key = "n",
			mods = "LEADER",
			action = wezterm.action.ActivateTabRelative(1),
		},
		-- move the previous tab
		{
			key = "p",
			mods = "LEADER",
			action = wezterm.action.ActivateTabRelative(-1),
		},
	}
end

return config
