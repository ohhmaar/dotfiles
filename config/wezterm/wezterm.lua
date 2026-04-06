local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "xterm-256color"
config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font_with_fallback({
	"JetBrains Mono NL",
	"JetBrains Mono",
})
config.font_size = 16

config.max_fps = 120
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}

config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false
config.window_decorations = "TITLE|RESIZE"
config.use_resize_increments = true
config.adjust_window_size_when_changing_font_size = false

config.scrollback_lines = 10000

config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

return config
