local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("mappings").apply(config)
require("options").apply(config)

return config
