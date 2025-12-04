local wezterm = require("wezterm")
local act = wezterm.action
local platform = require("custom.platform") -- Your platform detection module
local OS = platform.OS

local M = {}

-- leader
M.leader = { key = "e", mods = "ALT", timeout_milliseconds = 1500 }

-- Define modifier keys per platform
local mods = {
    leader = "LEADER",
    leader_shift = "SHIFT|LEADER",
    alt = "ALT",
    cmd = "SUPER",
    ctrl = "CTRL",
    primary = platform.isWindows() and "CTRL" or "SUPER",
    secondary = platform.isWindows() and "SHIFT|CTRL" or "SHIFT|SUPER",
}

M.keys = {}

local function map(key, modifier, action)
    table.insert(M.keys, { key = key, mods = modifier, action = action })
end

---Map a key only on certain OS/OSes.
---@alias OsEnum '"WINDOWS"'|'"MAC"'|'"LINUX"'|'"UNKNOWN"'
---@param os_or_list OsEnum|OsEnum[]
---@param key        string
---@param modifier   string|nil
---@param action     any
local function osmap(os_or_list, key, modifier, action)
    local current = platform.current()
    -- scalar
    if type(os_or_list) ~= "table" then
        if current == os_or_list then
            map(key, modifier, action)
        end
        return
    end
    -- list
    for _, os in ipairs(os_or_list) do
        if current == os then
            map(key, modifier, action)
            return
        end
    end
end

-- Navigation

-- leader d - go back tab
map("d", mods.leader, act.ActivateLastTab)
-- leader a - go all pane
map("p", mods.primary, act.PaneSelect)
-- leader h - go left pane
map("h", mods.leader, act.ActivatePaneDirection("Left"))
-- leader h - go right pane
map("j", mods.leader, act.ActivatePaneDirection("Down"))
-- leader k - go up pane
map("k", mods.leader, act.ActivatePaneDirection("Up"))
-- leader k - go down pane
map("l", mods.leader, act.ActivatePaneDirection("Right"))
-- leader t - new tab
map("t", mods.leader, act.SpawnTab("CurrentPaneDomain"))
map("t", mods.primary, act.SpawnTab("CurrentPaneDomain"))
-- leader v - new pane vertical split to the right
map("v", mods.leader, act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
-- leader s - new pane horizontal split to the bottom
map("s", mods.leader, act.SplitVertical({ domain = "CurrentPaneDomain" }))
-- leader x - close pane
map("x", mods.leader, act.CloseCurrentPane({ confirm = true }))
-- leader w - close tab
map("w", mods.leader, act.CloseCurrentTab({ confirm = true }))
map("w", mods.primary, act.CloseCurrentTab({ confirm = true }))

-- leader q - close window
map("q", mods.leader, act.QuitApplication)
map("q", mods.primary, act.QuitApplication)

-- leader z - toggle maximize pane
map("z", mods.leader, act.TogglePaneZoomState)

-- leader <n> - go to tab <n>
map("1", mods.primary, act.ActivateTab(0))
map("2", mods.primary, act.ActivateTab(1))
map("3", mods.primary, act.ActivateTab(2))
map("4", mods.primary, act.ActivateTab(3))
map("5", mods.primary, act.ActivateTab(4))
map("6", mods.primary, act.ActivateTab(5))
map("7", mods.primary, act.ActivateTab(6))
map("8", mods.primary, act.ActivateTab(7))
map("9", mods.primary, act.ActivateTab(8))

-- leader ctrl <n> - move tab <n>
map("1", mods.leader, act.MoveTab(0))
map("2", mods.leader, act.MoveTab(1))
map("3", mods.leader, act.MoveTab(2))
map("4", mods.leader, act.MoveTab(3))
map("5", mods.leader, act.MoveTab(4))
map("6", mods.leader, act.MoveTab(5))
map("7", mods.leader, act.MoveTab(6))
map("8", mods.leader, act.MoveTab(7))
map("9", mods.leader, act.MoveTab(8))

-- Editing

-- backspace a word
osmap(OS.WINDOWS, "Backspace", mods.ctrl, act.SendString("\x17"))
osmap({ OS.LINUX, OS.MAC }, "Backspace", mods.alt, act.SendString("\x17"))

-- backspace to line start
osmap({ OS.LINUX, OS.MAC }, "Backspace", mods.cmd, act.SendString("\x15"))

-- Tools & Features
map("f", mods.leader, act.Search("CurrentSelectionOrEmptyString"))
map("p", mods.secondary, act.ActivateCommandPalette)
map("r", mods.leader, act.ReloadConfiguration)
map("-", mods.leader, act.ShowDebugOverlay)
map("phys:Space", mods.leader, act.QuickSelect)
map("u", mods.leader, act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }))

-- Text Operations
map("c", mods.secondary, act.CopyTo("Clipboard"))
map("c", mods.primary, act.CopyTo("Clipboard"))
map("v", mods.secondary, act.PasteFrom("Clipboard"))
map("v", mods.primary, act.PasteFrom("Clipboard"))
map("k", mods.secondary, act.ClearScrollback("ScrollbackOnly"))
map("k", mods.primary, act.ClearScrollback("ScrollbackOnly"))
map("x", mods.primary, act.ActivateCopyMode)

-- Scrolling
map("y", mods.primary, act.ScrollByLine(-1))
map("e", mods.primary, act.ScrollByLine(1))
map("PageUp", "SHIFT", act.ScrollByPage(-1))
map("PageDown", "SHIFT", act.ScrollByPage(1))

-- Font Size
-- map("0", mods.primary, act.ResetFontSize)
-- map("+", mods.primary, act.IncreaseFontSize)
-- map("-", mods.primary, act.DecreaseFontSize)
-- map("=", mods.primary, act.IncreaseFontSize)
-- map("_", mods.primary, act.DecreaseFontSize)
-- map("+", mods.secondary, act.IncreaseFontSize)
-- map("-", mods.secondary, act.DecreaseFontSize)
-- map("=", mods.secondary, act.IncreaseFontSize)
-- map("_", mods.secondary, act.DecreaseFontSize)

-- Page Navigation
map("PageUp", mods.primary, act.ActivateTabRelative(-1))
map("PageDown", mods.primary, act.ActivateTabRelative(1))
map("PageUp", mods.secondary, act.MoveTabRelative(-1))
map("PageDown", mods.secondary, act.MoveTabRelative(1))

-- Pane Resizing
map("LeftArrow", "SHIFT|ALT|CTRL", act.AdjustPaneSize({ "Left", 1 }))
map("RightArrow", "SHIFT|ALT|CTRL", act.AdjustPaneSize({ "Right", 1 }))
map("UpArrow", "SHIFT|ALT|CTRL", act.AdjustPaneSize({ "Up", 1 }))
map("DownArrow", "SHIFT|ALT|CTRL", act.AdjustPaneSize({ "Down", 1 }))

-- Clipboard Operations
map("Insert", "SHIFT", act.PasteFrom("PrimarySelection"))
map("Insert", mods.primary, act.CopyTo("PrimarySelection"))
map("Copy", "NONE", act.CopyTo("Clipboard"))
map("Paste", "NONE", act.PasteFrom("Clipboard"))

-- Toggle Opacity (Custom function)
map(
    "o",
    mods.leader,
    wezterm.action_callback(
        function(window, _)
            local overrides = window:get_config_overrides() or {}
            if overrides.window_background_opacity == 1.0 then
                overrides.window_background_opacity = 0.9
            else
                overrides.window_background_opacity = 1.0
            end
            window:set_config_overrides(overrides)
        end
    )
)

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

-- display leader
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

return M
