local wezterm = require("wezterm")

return function(config)
	config.default_prog = { "pwsh.exe" }

	-- Tmux like behavior
	config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
	config.keys = {
		-- split the window vertically
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		-- split the window horizontally
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
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
		-- adjust pane size
		{
			key = "J",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Down", 10 }),
		},
		{
			key = "K",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Up", 10 }),
		},
		{
			key = "L",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Right", 30 }),
		},
		{
			key = "H",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Left", 30 }),
		},
	}
end
