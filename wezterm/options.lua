
M = {}

local wezterm = require("wezterm")
local platform = require("lib.platform")

function M.apply(config)
    config.automatically_reload_config = false
    config.max_fps = 120
    config.audible_bell = "Disabled"

    -- font
    config.font = wezterm.font_with_fallback {
        'JetBrainsMono Nerd Font Mono',
        'Menlo',
        'Consolas',
        'monospace'
    }
    if platform.isMac() then
        config.font_size = 16
    else
        config.font_size = 12.25
    end
    config.line_height = 0.9

    -- theme
    config.color_scheme = "Catppuccin Mocha"
    if platform.isMac() then
        config.window_background_opacity = 0.9
    else
        config.window_background_opacity = 1.0
    end

    -- tab
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = true

    if platform.isWindows() then
        config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe', '-nologo' }
        config.window_decorations = "RESIZE" -- Remove window title bar
    elseif platform.isMac() then
        config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

        local mux = wezterm.mux

        wezterm.on("gui-startup", function()
            local tab, pane, window = mux.spawn_window{}
            window:gui_window():maximize()
        end)

    elseif platform.isLinux() then
        config.default_prog = { '/bin/bash', '-l' }
    end

    -- cursor
    config.default_cursor_style = 'BlinkingUnderline'
    config.animation_fps = 60
    config.cursor_thickness = "4px"

    -- disable default keymaps
    config.disable_default_key_bindings = true

    -- layout
    config.window_padding = {
        left = '0.6cell',
        right = '0.6cell',
        top = '0.4cell',
        bottom = '0.4cell',
    }

    -- active pane color
    config.inactive_pane_hsb = {
        saturation = 0.8,
        brightness = 0.5,
    }
end

return M
