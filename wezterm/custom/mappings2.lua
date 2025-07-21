local wezterm = require("wezterm")
local platform = require("custom.platform") -- Your platform detection module
local act = wezterm.action

local M = {}

-- Leader key (consistent across platforms)
M.leader = { key = "e", mods = "ALT", timeout_milliseconds = 1500 }

-- Define modifier keys per platform
local mods = {
    -- Primary modifier (Ctrl on Windows/Linux, Cmd on Mac)
    primary = platform.isMac() and "SUPER" or "CTRL",
    -- Secondary modifier (usually with Shift)
    secondary = platform.isMac() and "SHIFT|SUPER" or "SHIFT|CTRL",
    -- Alternative modifier
    alt = "ALT",
    -- Leader modifier (consistent)
    leader = "LEADER",
}

-- ========== COMMON KEYS (Cross-platform) ==========
local common_keys = {
    -- Navigation
    { key = "d", mods = mods.leader, action = act.ActivateLastTab },
    { key = "b", mods = mods.leader, action = act.ActivateTabRelative(-1) },
    { key = "n", mods = mods.leader, action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = mods.primary, action = act.ActivateTabRelative(1) },
    { key = "Tab", mods = mods.secondary, action = act.ActivateTabRelative(-1) },

    -- Pane navigation (ALT + vim keys)
    { key = "h", mods = mods.alt, action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = mods.alt, action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = mods.alt, action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = mods.alt, action = act.ActivatePaneDirection("Right") },
    { key = "p", mods = mods.alt, action = act.PaneSelect },

    -- Arrow key pane navigation
    { key = "LeftArrow", mods = mods.secondary, action = act.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = mods.secondary, action = act.ActivatePaneDirection("Right") },
    { key = "UpArrow", mods = mods.secondary, action = act.ActivatePaneDirection("Up") },
    { key = "DownArrow", mods = mods.secondary, action = act.ActivatePaneDirection("Down") },

    -- Window/Tab/Pane Management
    { key = "t", mods = mods.leader, action = act.SpawnTab("CurrentPaneDomain") },
    { key = "v", mods = mods.leader, action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "s", mods = mods.leader, action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "x", mods = mods.leader, action = act.CloseCurrentPane({ confirm = true }) },
    { key = "w", mods = mods.leader, action = act.CloseCurrentTab({ confirm = true }) },
    { key = "w", mods = mods.primary, action = act.CloseCurrentTab({ confirm = true }) },
    { key = "z", mods = mods.leader, action = act.TogglePaneZoomState },

    -- Move current tab to specific positions
    { key = '1', mods = 'LEADER|SHIFT', action = act.MoveTab(0) },
    { key = '2', mods = 'LEADER|SHIFT', action = act.MoveTab(1) },
    { key = '3', mods = 'LEADER|SHIFT', action = act.MoveTab(2) },
    { key = '4', mods = 'LEADER|SHIFT', action = act.MoveTab(3) },
    { key = '5', mods = 'LEADER|SHIFT', action = act.MoveTab(4) },
    { key = '6', mods = 'LEADER|SHIFT', action = act.MoveTab(5) },
    { key = '7', mods = 'LEADER|SHIFT', action = act.MoveTab(6) },
    { key = '8', mods = 'LEADER|SHIFT', action = act.MoveTab(7) },
    { key = '9', mods = 'LEADER|SHIFT', action = act.MoveTab(8) },

    -- Tools & Features
    { key = "f", mods = mods.leader, action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "p", mods = mods.leader, action = act.ActivateCommandPalette },
    { key = "r", mods = mods.leader, action = act.ReloadConfiguration },
    { key = "l", mods = mods.leader, action = act.ShowDebugOverlay },
    { key = "phys:Space", mods = mods.leader, action = act.QuickSelect },
    {
        key = "u",
        mods = mods.leader,
        action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
    },

    -- Text Operations
    { key = "c", mods = mods.secondary, action = act.CopyTo("Clipboard") },
    { key = "c", mods = mods.primary, action = act.CopyTo("Clipboard") },
    { key = "v", mods = mods.secondary, action = act.PasteFrom("Clipboard") },
    { key = "v", mods = mods.primary, action = act.PasteFrom("Clipboard") },
    { key = "k", mods = mods.secondary, action = act.ClearScrollback("ScrollbackOnly") },
    { key = "k", mods = mods.primary, action = act.ClearScrollback("ScrollbackOnly") },
    { key = "x", mods = mods.primary, action = act.ActivateCopyMode },

    -- Scrolling
    { key = "y", mods = mods.primary, action = act.ScrollByLine(-1) },
    { key = "e", mods = mods.primary, action = act.ScrollByLine(1) },
    { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
    { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },

    -- Font Size
    { key = "0", mods = mods.primary, action = act.ResetFontSize },
    { key = "+", mods = mods.primary, action = act.IncreaseFontSize },
    { key = "-", mods = mods.primary, action = act.DecreaseFontSize },
    { key = "=", mods = mods.primary, action = act.IncreaseFontSize },
    { key = "_", mods = mods.primary, action = act.DecreaseFontSize },
    { key = "+", mods = mods.secondary, action = act.IncreaseFontSize },
    { key = "-", mods = mods.secondary, action = act.DecreaseFontSize },
    { key = "=", mods = mods.secondary, action = act.IncreaseFontSize },
    { key = "_", mods = mods.secondary, action = act.DecreaseFontSize },

    -- Page Navigation
    { key = "PageUp", mods = mods.primary, action = act.ActivateTabRelative(-1) },
    { key = "PageDown", mods = mods.primary, action = act.ActivateTabRelative(1) },
    { key = "PageUp", mods = mods.secondary, action = act.MoveTabRelative(-1) },
    { key = "PageDown", mods = mods.secondary, action = act.MoveTabRelative(1) },

    -- Pane Resizing
    { key = "LeftArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "RightArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "UpArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "DownArrow", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },

    -- Clipboard Operations
    { key = "Insert", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
    { key = "Insert", mods = mods.primary, action = act.CopyTo("PrimarySelection") },
    { key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
    { key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },

    -- Toggle Opacity (Custom function)
    {
        key = "o",
        mods = mods.leader,
        action = wezterm.action_callback(function(window, _)
            local overrides = window:get_config_overrides() or {}
            if overrides.window_background_opacity == 1.0 then
                overrides.window_background_opacity = 0.9
            else
                overrides.window_background_opacity = 1.0
            end
            window:set_config_overrides(overrides)
        end),
    },
}

-- ========== NUMBERED TABS ==========
for i = 1, 9 do
    table.insert(common_keys, {
        key = tostring(i),
        mods = mods.leader,
        action = wezterm.action.ActivateTab(i - 1),
    })
end
table.insert(common_keys, { key = "0", mods = mods.leader, action = act.ActivateTab(-1) })

-- ========== WINDOWS/LINUX SPECIFIC KEYS ==========
local windows_keys = {
    -- Delete word
    { key = "Backspace", mods = "CTRL", action = act.SendString("\x17") },
}

-- ========== MACOS SPECIFIC KEYS ==========
local macos_keys = {
    -- Delete operations
    { key = "Backspace", mods = "SUPER", action = act.SendString("\x15") }, -- Delete line
    { key = "Backspace", mods = "ALT", action = act.SendString("\x17") }, -- Delete word

    -- Tab navigation with curly braces
    { key = "{", mods = "SUPER", action = act.ActivateTabRelative(-1) },
    { key = "{", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(-1) },
    { key = "}", mods = "SUPER", action = act.ActivateTabRelative(1) },
    { key = "}", mods = "SHIFT|SUPER", action = act.ActivateTabRelative(1) },

    -- Additional macOS-style font size controls
    { key = "=", mods = "SUPER", action = act.IncreaseFontSize },
    { key = "-", mods = "SUPER", action = act.DecreaseFontSize },
}

-- ========== BUILD FINAL KEYS TABLE ==========
M.keys = {}

-- Add common keys
for _, key in ipairs(common_keys) do
    table.insert(M.keys, key)
end

-- Add platform-specific keys
if platform.isMac() then
    for _, key in ipairs(macos_keys) do
        table.insert(M.keys, key)
    end
elseif platform.isWindows() or platform.isLinux() then
    for _, key in ipairs(windows_keys) do
        table.insert(M.keys, key)
    end
end

-- ========== KEY TABLES ==========
M.key_tables = {
    copy_mode = {
        -- Movement
        { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
        { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
        { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
        { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
        { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
        { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
        { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
        { key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
        { key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
        { key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
        { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
        { key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
        { key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
        { key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
        { key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },

        -- Selection
        { key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
        { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
        { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
        { key = "v", mods = mods.primary, action = act.CopyMode({ SetSelectionMode = "Block" }) },
        { key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
        { key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

        -- Jumping
        { key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
        { key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
        { key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
        { key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
        { key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
        { key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },

        -- Scrolling
        { key = "d", mods = mods.primary, action = act.CopyMode({ MoveByPage = 0.5 }) },
        { key = "u", mods = mods.primary, action = act.CopyMode({ MoveByPage = -0.5 }) },
        { key = "b", mods = mods.primary, action = act.CopyMode("PageUp") },
        { key = "f", mods = mods.primary, action = act.CopyMode("PageDown") },
        { key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
        { key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },

        -- Actions
        {
            key = "y",
            mods = "NONE",
            action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
        },
        { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
        { key = "q", mods = "NONE", action = act.CopyMode("Close") },
        { key = "c", mods = mods.primary, action = act.CopyMode("Close") },
        { key = "g", mods = mods.primary, action = act.CopyMode("Close") },
        { key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },

        -- Additional movement
        { key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
        { key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
        { key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
        { key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
        { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
        { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
        { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
        { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
        { key = "LeftArrow", mods = mods.alt, action = act.CopyMode("MoveBackwardWord") },
        { key = "RightArrow", mods = mods.alt, action = act.CopyMode("MoveForwardWord") },

        -- Alt movement
        { key = "b", mods = mods.alt, action = act.CopyMode("MoveBackwardWord") },
        { key = "f", mods = mods.alt, action = act.CopyMode("MoveForwardWord") },
        { key = "m", mods = mods.alt, action = act.CopyMode("MoveToStartOfLineContent") },

        -- Shift variants
        { key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
        { key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
        { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
        { key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
        { key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
        { key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
        { key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
        { key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
        { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
        { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
    },

    search_mode = {
        { key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
        { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
        { key = "n", mods = mods.primary, action = act.CopyMode("NextMatch") },
        { key = "p", mods = mods.primary, action = act.CopyMode("PriorMatch") },
        { key = "r", mods = mods.primary, action = act.CopyMode("CycleMatchType") },
        { key = "u", mods = mods.primary, action = act.CopyMode("ClearPattern") },
        { key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
        { key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
        { key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
        { key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
    },
}

-- Register event callbacks
function M.register_events()
    wezterm.on("update-right-status", function(window, _)
        local prefix = ""
        if window:leader_is_active() then
            prefix = " " .. utf8.char(0x2605) .. " "
        else
            prefix = "   "
        end
        window:set_left_status(wezterm.format({
            { Background = { Color = "#18181e" } },
            { Text = prefix },
        }))
    end)
end

return M
