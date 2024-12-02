-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

config.keys = {
	-- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
	{
		key = "LeftArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = act.SendKey({ key = "f", mods = "ALT" }),
	},
}

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"

config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", scale = 1.2, weight = "Medium" },
	{ family = "Hack Nerd Font", scale = 1.3 },
})

config.enable_tab_bar = false
--config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
