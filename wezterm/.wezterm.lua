-- Pull in the wezterm API
local wezterm = require 'wezterm'
-- This table will hold the configuration.
local config = {}
local act = wezterm.action

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
-- This is where you actually apply your config choices
-- For example, changing the color scheme:
config.color_scheme = 'GruvboxDarkHard'
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.font = wezterm.font("JetBrains Mono Medium")
config.font_rules = {
  {
    italic = false,
    intensity = "Half",
    font = wezterm.font("JetBrains Mono Medium"),
  },
  {
    italic = true,
    intensity = "Half",
    font = wezterm.font("JetBrains Mono Italic"),
  },
  {
    italic = false,
    intensity = "Bold",
    font = wezterm.font("JetBrains Mono Bold"),
  },
  {
    italic = true,
    intensity = "Bold",
    font = wezterm.font("JetBrains Mono Bold Italic"),
  },
}
config.font_size = 15.0
config.keys = {
  { key = "l", mods = "CTRL", action = wezterm.action.ShowLauncher },
  { key = '{', mods = 'ALT',  action = act.ActivateTabRelative(-1) },
  { key = '}', mods = 'ALT',  action = act.ActivateTabRelative(1) },

}
config.window_background_opacity = .9
-- Default program
-- config.default_prog = { "powershell.exe", "ubuntu", "-c", "zsh" }
config.default_prog = { "/bin/zsh" }
config.launch_menu = {
  {
    label = "Windows: WSL (Ubuntu ZSH)",
    args = { "powershell.exe", "ubuntu", "-c", "zsh" }
  },
  {
    label = "Windows: Dev Container (Archlinux)",
    args = { "ubuntu", "-c", "zsh", "cd $HOME/dev-containers && make run" }
  },
  {
    label = "OSX: ZSH",
    args = { "/bin/zsh" }
  },
  {
    label = "OSX: Dev Container (Archlinux)",
    args = { "/bin/zsh", "cd $HOME/dev-containers/ && make run" }
  }
}
return config
