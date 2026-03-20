local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- local mux = wezterm.mux

config.default_domain = "WSL:Pengwin"

config.font_size = 12
config.font = wezterm.font_with_fallback({
	"Comic Code Ligatures",
	"Symbols Nerd Font Mono",
})

config.window_close_confirmation = "NeverPrompt"
-- config.window_decorations = "NONE"
config.window_background_opacity = 0.98
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = "Gruvbox dark, hard (base16)"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

wezterm.on("gui-startup", function(cmd)
	local screen = wezterm.gui.screens().active
	local ratio = 0.6
	local width, height = screen.width * ratio, screen.height * ratio
	local tab, pane, window = wezterm.mux.spawn_window({
		position = {
			x = (screen.width - width) / 2,
			y = (screen.height - height) / 2,
			origin = "ActiveScreen",
		},
	})
	window:gui_window():set_inner_size(width, height)
end)

return config
