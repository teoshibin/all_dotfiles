
M = {}

local wezterm = require("wezterm")
local platform = require("lib.platform")

-- per-window state
local opacity_by_window = {}

local function configure_colorscheme()
    DEFAULT_THEME = "Catppuccin Mocha"
    SSH_THEME = "Cobalt2"

    local function apply_overrides(window, pane)
        local id = window:window_id()
        local opacity = opacity_by_window[id] -- may be nil

        local overrides = window:get_config_overrides() or {}

        -- keep opacity override stable
        if opacity ~= nil then
            overrides.window_background_opacity = opacity
        else
            overrides.window_background_opacity = nil
        end

        -- theme switch
        local fg = pane and pane:get_foreground_process_name() or ""
        overrides.color_scheme = (fg == "/usr/bin/ssh") and SSH_THEME or DEFAULT_THEME

        local dimmed = (opacity ~= nil and opacity < 0.999)
        if platform.isWindows() then
            -- overrides.win32_system_backdrop = dimmed and "Acrylic" or nil
        elseif platform.isMac() then
            overrides.macos_window_background_blur = dimmed and 20 or nil
        elseif platform.isLinux() then
            overrides.kde_window_background_blur = dimmed and true or nil
        end

        window:set_config_overrides(overrides)
    end

    -- update theme on ssh
    wezterm.on("update-status", function(window, pane)
        apply_overrides(window, pane)
    end)

    -- update theme on opacity toggle
    wezterm.on("toggle-opacity", function(window, pane)
        local id = window:window_id()
        local cur = opacity_by_window[id]

        if cur == nil or cur >= 0.999 then
            opacity_by_window[id] = 0.9
        else
            opacity_by_window[id] = 1.0
        end

        apply_overrides(window, pane)
    end)
end

function M.configure(config)
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
    configure_colorscheme(config)

    -- tab
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = true

    if platform.isWindows() then
        config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe', '-nologo' }
        config.window_decorations = "RESIZE" -- Remove window title bar
    elseif platform.isMac() then
        config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

        -- patch: disable left Option key composition so alt+backspace word delete works;
        -- use right Option for macOS accent characters instead
        config.send_composed_key_when_left_alt_is_pressed = false

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

    config.window_background_opacity = 0.9
end

return M
