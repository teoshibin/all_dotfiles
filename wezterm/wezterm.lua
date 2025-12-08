local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("mappings").configure(config)
require("options").configure(config)

return config
