-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Batman'

-- Set background to same color as neovim
config.colors = {}
config.colors.background = '#111111'

config.font = wezterm.font_with_fallback {
    'DejaVuSansM Nerd Font Mono',
 --  'nonicons',
}

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.enable_tab_bar = false
config.show_new_tab_button_in_tab_bar =false
config.show_tabs_in_tab_bar = false
config.tab_bar_at_bottom = false
config.freetype_load_target = "HorizontalLcd"
config.disable_default_key_bindings = true
config.keys ={
        {
            key="C", 
            mods="CTRL|SHIFT", 
            action=wezterm.action{CopyTo="Clipboard"}
        },
        {
            key="V", 
            mods="CTRL|SHIFT", 
            action=wezterm.action{PasteFrom="Clipboard"}
        }
,
}
-- and finally, return the configuration to wezterm
return config
