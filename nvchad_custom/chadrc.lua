---@type ChadrcConfig
local M = {}
-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "bk_darcula",
  theme_toggle = { "bk_darcula", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
   nvdash = {
    load_on_startup = true,
  },
  statusline = {
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    overriden_modules = nil,
  },

}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M