
M = {}

local wezterm = require("wezterm")
local act = wezterm.action
local Mapper = require("lib.mapper")
local mods = Mapper.mods

-- Configure leader key
local function leader()
    return { key = "e", mods = mods.alt, timeout_milliseconds = 1500 }
end

-- Configure general keys
local function key()
    local mapper  = Mapper.new()
    local map     = mapper.map
    local unixmap = mapper.unixmap
    local winmap  = mapper.winmap

    -- Navigation

    -- go back tab
    winmap("d", mods.ctrl_shift, act.ActivateLastTab)
    unixmap("d", mods.cmd, act.ActivateLastTab)

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
    map("f", mods.leader, act.Search({ CaseInSensitiveString = "" }))
    winmap("f", mods.ctrl_shift, act.Search({ CaseInSensitiveString = "" }))
    unixmap("f", mods.cmd, act.Search({ CaseInSensitiveString = "" }))

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
    map("Copy", mods.none, act.CopyTo("Clipboard"))
    map("Paste", mods.none, act.PasteFrom("Clipboard"))

    -- toggle opacity
    map("o", mods.leader, act.EmitEvent("toggle-opacity"))

    return mapper.keys
end

-- Configure copy mode keys
local function copyMode()
    local mapper  = Mapper.new()
    local map     = mapper.map
    local unixmap = mapper.unixmap
    local winmap  = mapper.winmap

    -- Movement
    map("h", mods.none, act.CopyMode("MoveLeft"))
    map("j", mods.none, act.CopyMode("MoveDown"))
    map("k", mods.none, act.CopyMode("MoveUp"))
    map("l", mods.none, act.CopyMode("MoveRight"))
    map("w", mods.none, act.CopyMode("MoveForwardWord"))
    map("b", mods.none, act.CopyMode("MoveBackwardWord"))
    map("e", mods.none, act.CopyMode("MoveForwardWordEnd"))
    map("0", mods.none, act.CopyMode("MoveToStartOfLine"))
    map("$", mods.none, act.CopyMode("MoveToEndOfLineContent"))
    map("^", mods.none, act.CopyMode("MoveToStartOfLineContent"))
    map("g", mods.none, act.CopyMode("MoveToScrollbackTop"))
    map("G", mods.none, act.CopyMode("MoveToScrollbackBottom"))
    map("H", mods.none, act.CopyMode("MoveToViewportTop"))
    map("M", mods.none, act.CopyMode("MoveToViewportMiddle"))
    map("L", mods.none, act.CopyMode("MoveToViewportBottom"))

    -- Selection
    map("Space", mods.none, act.CopyMode({ SetSelectionMode = "Cell" }))
    map("v",     mods.none, act.CopyMode({ SetSelectionMode = "Cell" }))
    map("V",     mods.none, act.CopyMode({ SetSelectionMode = "Line" }))
    winmap("v",  mods.ctrl, act.CopyMode({ SetSelectionMode = "Block" }))
    unixmap("v", mods.cmd,  act.CopyMode({ SetSelectionMode = "Block" }))
    map("o", mods.none, act.CopyMode("MoveToSelectionOtherEnd"))
    map("O", mods.none, act.CopyMode("MoveToSelectionOtherEndHoriz"))

    -- Jumping
    map("f", mods.none, act.CopyMode({ JumpForward  = { prev_char = false } }))
    map("F", mods.none, act.CopyMode({ JumpBackward = { prev_char = false } }))
    map("t", mods.none, act.CopyMode({ JumpForward  = { prev_char = true } }))
    map("T", mods.none, act.CopyMode({ JumpBackward = { prev_char = true } }))
    map(";", mods.none, act.CopyMode("JumpAgain"))
    map(",", mods.none, act.CopyMode("JumpReverse"))

    -- Scrolling
    winmap("d",  mods.ctrl, act.CopyMode({ MoveByPage = 0.5 }))
    unixmap("d", mods.cmd,  act.CopyMode({ MoveByPage = 0.5 }))
    winmap("u",  mods.ctrl, act.CopyMode({ MoveByPage = -0.5 }))
    unixmap("u", mods.cmd,  act.CopyMode({ MoveByPage = -0.5 }))
    winmap("b",  mods.ctrl, act.CopyMode("PageUp"))
    unixmap("b", mods.cmd,  act.CopyMode("PageUp"))
    winmap("f",  mods.ctrl, act.CopyMode("PageDown"))
    unixmap("f", mods.cmd,  act.CopyMode("PageDown"))
    map("PageUp",   mods.none, act.CopyMode("PageUp"))
    map("PageDown", mods.none, act.CopyMode("PageDown"))

    -- Actions
    map("y", mods.none, act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }))
    map("Escape", mods.none, act.CopyMode("Close"))
    map("q",      mods.none, act.CopyMode("Close"))
    winmap("c",  mods.ctrl, act.CopyMode("Close"))
    unixmap("c", mods.cmd,  act.CopyMode("Close"))
    winmap("g",  mods.ctrl, act.CopyMode("Close"))
    unixmap("g", mods.cmd,  act.CopyMode("Close"))
    map("Enter", mods.none, act.CopyMode("MoveToStartOfNextLine"))

    -- Additional movement
    map("Tab",        mods.none,  act.CopyMode("MoveForwardWord"))
    map("Tab",        mods.shift, act.CopyMode("MoveBackwardWord"))
    map("End",        mods.none,  act.CopyMode("MoveToEndOfLineContent"))
    map("Home",       mods.none,  act.CopyMode("MoveToStartOfLine"))
    map("LeftArrow",  mods.none,  act.CopyMode("MoveLeft"))
    map("RightArrow", mods.none,  act.CopyMode("MoveRight"))
    map("UpArrow",    mods.none,  act.CopyMode("MoveUp"))
    map("DownArrow",  mods.none,  act.CopyMode("MoveDown"))
    map("LeftArrow",  mods.alt, act.CopyMode("MoveBackwardWord"))
    map("RightArrow", mods.alt, act.CopyMode("MoveForwardWord"))

    -- Alt movement
    map("b", mods.alt, act.CopyMode("MoveBackwardWord"))
    map("f", mods.alt, act.CopyMode("MoveForwardWord"))
    map("m", mods.alt, act.CopyMode("MoveToStartOfLineContent"))

    -- Shift variants
    map("$", mods.shift, act.CopyMode("MoveToEndOfLineContent"))
    map("F", mods.shift, act.CopyMode({ JumpBackward = { prev_char = false } }))
    map("G", mods.shift, act.CopyMode("MoveToScrollbackBottom"))
    map("H", mods.shift, act.CopyMode("MoveToViewportTop"))
    map("L", mods.shift, act.CopyMode("MoveToViewportBottom"))
    map("M", mods.shift, act.CopyMode("MoveToViewportMiddle"))
    map("O", mods.shift, act.CopyMode("MoveToSelectionOtherEndHoriz"))
    map("T", mods.shift, act.CopyMode({ JumpBackward = { prev_char = true } }))
    map("V", mods.shift, act.CopyMode({ SetSelectionMode = "Line" }))
    map("^", mods.shift, act.CopyMode("MoveToStartOfLineContent"))

    return mapper.keys
end

-- Configure search mode keys
local function searchMode()
    local mapper  = Mapper.new()
    local map     = mapper.map
    local unixmap = mapper.unixmap
    local winmap  = mapper.winmap

    map("Enter",     mods.none, act.CopyMode("PriorMatch"))
    map("Escape",    mods.none, act.CopyMode("Close"))
    winmap("n",  mods.ctrl, act.CopyMode("NextMatch"))
    unixmap("n", mods.cmd,  act.CopyMode("NextMatch"))
    winmap("p",  mods.ctrl, act.CopyMode("PriorMatch"))
    unixmap("p", mods.cmd,  act.CopyMode("PriorMatch"))
    winmap("r",  mods.ctrl, act.CopyMode("CycleMatchType"))
    unixmap("r", mods.cmd,  act.CopyMode("CycleMatchType"))
    winmap("u",  mods.ctrl, act.CopyMode("ClearPattern"))
    unixmap("u", mods.cmd,  act.CopyMode("ClearPattern"))
    map("PageUp",    mods.none, act.CopyMode("PriorMatchPage"))
    map("PageDown",  mods.none, act.CopyMode("NextMatchPage"))
    map("UpArrow",   mods.none, act.CopyMode("PriorMatch"))
    map("DownArrow", mods.none, act.CopyMode("NextMatch"))

    return mapper.keys
end

function M.configure(config)
    config.leader = leader()
    config.keys = key()
    config.key_tables = { copy_mode = copyMode(), search_mode = searchMode() }

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
