
M = {}

local wezterm = require("wezterm")
local act = wezterm.action

local mapper = require("lib.mapper")
local mods = mapper.mods
local map = mapper.map
local unixmap = mapper.unixmap
local winmap = mapper.winmap

M.leader = { key = "e", mods = mods.alt, timeout_milliseconds = 1500 }
M.keys = mapper.keys

-- Navigation

-- go back tab
map("d", mods.leader, act.ActivateLastTab)

-- go all pane
winmap("p", mods.ctrl_shift, act.PaneSelect)
unixmap("p", mods.cmd, act.PaneSelect)

-- go left pane
map("h", mods.leader, act.ActivatePaneDirection("Left"))

-- go right pane
map("j", mods.leader, act.ActivatePaneDirection("Down"))

-- go up pane
map("k", mods.leader, act.ActivatePaneDirection("Up"))

-- go down pane
map("l", mods.leader, act.ActivatePaneDirection("Right"))

-- new tab
map("t", mods.leader, act.SpawnTab("CurrentPaneDomain"))
winmap("t", mods.ctrl, act.SpawnTab("CurrentPaneDomain"))
unixmap("t", mods.cmd, act.SpawnTab("CurrentPaneDomain"))

-- new pane vertical split to the right
map("v", mods.leader, act.SplitHorizontal({ domain = "CurrentPaneDomain" }))

-- new pane horizontal split to the bottom
map("s", mods.leader, act.SplitVertical({ domain = "CurrentPaneDomain" }))

-- close pane
map("x", mods.leader, act.CloseCurrentPane({ confirm = true }))

-- close tab
map("w", mods.leader, act.CloseCurrentTab({ confirm = true }))
winmap("w", mods.ctrl, act.CloseCurrentTab({ confirm = true }))
unixmap("w", mods.cmd, act.CloseCurrentTab({ confirm = true }))

-- close window
map("q", mods.leader, act.QuitApplication)
winmap("q", mods.ctrl, act.QuitApplication)
unixmap("q", mods.cmd, act.QuitApplication)

-- toggle maximize pane
map("Enter", mods.leader, act.TogglePaneZoomState)

-- go to tab
winmap("1", mods.ctrl, act.ActivateTab(0))
winmap("2", mods.ctrl, act.ActivateTab(1))
winmap("3", mods.ctrl, act.ActivateTab(2))
winmap("4", mods.ctrl, act.ActivateTab(3))
winmap("5", mods.ctrl, act.ActivateTab(4))
winmap("6", mods.ctrl, act.ActivateTab(5))
winmap("7", mods.ctrl, act.ActivateTab(6))
winmap("8", mods.ctrl, act.ActivateTab(7))
winmap("9", mods.ctrl, act.ActivateTab(8))
unixmap("1", mods.cmd, act.ActivateTab(0))
unixmap("2", mods.cmd, act.ActivateTab(1))
unixmap("3", mods.cmd, act.ActivateTab(2))
unixmap("4", mods.cmd, act.ActivateTab(3))
unixmap("5", mods.cmd, act.ActivateTab(4))
unixmap("6", mods.cmd, act.ActivateTab(5))
unixmap("7", mods.cmd, act.ActivateTab(6))
unixmap("8", mods.cmd, act.ActivateTab(7))
unixmap("9", mods.cmd, act.ActivateTab(8))

-- move tab
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

-- backspace word
winmap("Backspace", mods.ctrl, act.SendString("\x17"))
unixmap("Backspace", mods.alt, act.SendString("\x17"))

-- backspace to start
unixmap("Backspace", mods.cmd, act.SendString("\x15"))

-- copy
winmap("c", mods.ctrl_shift, act.CopyTo("Clipboard"))
unixmap("c", mods.cmd, act.CopyTo("Clipboard"))

-- paste
winmap("v", mods.ctrl_shift, act.PasteFrom("Clipboard"))
unixmap("v", mods.cmd, act.PasteFrom("Clipboard"))

-- search on cursor
map("f", mods.leader, act.Search("CurrentSelectionOrEmptyString"))

-- command palette
map("p", mods.leader, act.ActivateCommandPalette)

-- reload configuration
map("r", mods.leader, act.ReloadConfiguration)

-- show debug
map("-", mods.leader, act.ShowDebugOverlay)

-- cursor select with regex
map("phys:Space", mods.leader, act.QuickSelect)

-- emoji selector
map("u", mods.leader, act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }))

-- clear scrollback
unixmap("k", mods.cmd, act.ClearScrollback("ScrollbackOnly"))
winmap("k", mods.ctrl_shift, act.ClearScrollback("ScrollbackOnly"))

-- copy mode
winmap("x", mods.ctrl, act.ActivateCopyMode)
unixmap("x", mods.cmd, act.ActivateCopyMode)

-- scroll
winmap("y", mods.ctrl, act.ScrollByLine(-1))
unixmap("y", mods.cmd, act.ScrollByLine(-1))
winmap("e", mods.ctrl, act.ScrollByLine(1))
unixmap("e", mods.cmd, act.ScrollByLine(1))
map("PageUp", mods.shift, act.ScrollByPage(-1))
map("PageDown", mods.shift, act.ScrollByPage(1))

-- increase font size
winmap("+", mods.ctrl, act.IncreaseFontSize)
unixmap("+", mods.cmd, act.IncreaseFontSize)

-- decrease font size
winmap("-", mods.ctrl, act.DecreaseFontSize)
unixmap("-", mods.cmd, act.DecreaseFontSize)

-- reset font size
winmap("0", mods.ctrl, act.ResetFontSize)
unixmap("0", mods.cmd, act.ResetFontSize)

-- focus previous tab
winmap("PageUp", mods.ctrl, act.ActivateTabRelative(-1))
unixmap("PageUp", mods.cmd, act.ActivateTabRelative(-1))

-- focus next tab
winmap("PageDown", mods.ctrl, act.ActivateTabRelative(1))
unixmap("PageDown", mods.cmd, act.ActivateTabRelative(1))

-- move to previous tab
winmap("PageUp", mods.ctrl_shift, act.MoveTabRelative(-1))
unixmap("PageUp", mods.cmd_shift, act.MoveTabRelative(-1))

-- move to next tab
winmap("PageDown", mods.ctrl_shift, act.MoveTabRelative(1))
unixmap("PageDown", mods.cmd_shift, act.MoveTabRelative(1))

-- resize left
map("LeftArrow", "SHIFT|ALT|CTRL", act.AdjustPaneSize({ "Left", 1 }))
map("RightArrow", "SHIFT|ALT|CTRL", act.AdjustPaneSize({ "Right", 1 }))
map("UpArrow", "SHIFT|ALT|CTRL", act.AdjustPaneSize({ "Up", 1 }))
map("DownArrow", "SHIFT|ALT|CTRL", act.AdjustPaneSize({ "Down", 1 }))

-- idk
map("Insert", mods.shift, act.PasteFrom("PrimarySelection"))

-- idk
winmap("Insert", mods.ctrl, act.CopyTo("PrimarySelection"))
unixmap("Insert", mods.cmd, act.CopyTo("PrimarySelection"))

-- idk
map("Copy", "NONE", act.CopyTo("Clipboard"))
map("Paste", "NONE", act.PasteFrom("Clipboard"))

-- toggle opacity
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

-- TODO: remove usage of primary and secondary
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

function M.configure(config)
    config.leader = M.leader
    config.keys = M.keys
    config.key_tables = M.key_tables

    -- display leader mode
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
