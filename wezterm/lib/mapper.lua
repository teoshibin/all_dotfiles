--
-- local M = {}
--
-- local platform = require("lib.platform")
-- local OS = platform.OS
--
-- M.mods = {
--     leader = "LEADER",
--     ctrl = "CTRL",
--     ctrl_shift = "CTRL|SHIFT",
--     alt = "ALT",
--     cmd = "SUPER",
--     cmd_shift = "SUPER|SHIFT",
--     shift = "SHIFT",
-- }
--
--
-- M.keys = {}
--
-- function M.map(key, modifier, action)
--     table.insert(M.keys, { key = key, mods = modifier, action = action })
-- end
--
-- ---Map a key only on certain OS/OSes.
-- ---@alias OsEnum '"WINDOWS"'|'"MAC"'|'"LINUX"'|'"UNKNOWN"'
-- ---@param os_or_list OsEnum|OsEnum[]
-- ---@param key        string
-- ---@param modifier   string|nil
-- ---@param action     any
-- local function osmap(os_or_list, key, modifier, action)
--     local current = platform.current()
--     if type(os_or_list) ~= "table" then
--         if current == os_or_list then
--             M.map(key, modifier, action)
--         end
--         return
--     end
--     for _, os in ipairs(os_or_list) do
--         if current == os then
--             M.map(key, modifier, action)
--             return
--         end
--     end
-- end
--
--
-- ---Map key only on unix like system
-- function M.unixmap(key, modifier, action)
--     osmap({ OS.LINUX, OS.MAC }, key, modifier, action)
-- end
--
-- ---Map key only on windows system
-- function M.winmap(key, modifier, action)
--     osmap(OS.WINDOWS, key, modifier, action)
-- end
--
-- return M
--
--

-- lib/mapper.lua
local platform = require("lib.platform")
local OS = platform.OS

local M = {}

M.mods = {
    leader      = "LEADER",
    ctrl        = "CTRL",
    ctrl_shift  = "CTRL|SHIFT",
    alt         = "ALT",
    cmd         = "SUPER",
    cmd_shift   = "SUPER|SHIFT",
    shift       = "SHIFT",
}

---Create a mapper bound to a specific keys table.
---@param existing_keys table[]|nil
---@return { keys: table[], map: function, unixmap: function, winmap: function }
function M.new(existing_keys)
    local keys = existing_keys or {}

    local function map(key, modifier, action)
        table.insert(keys, { key = key, mods = modifier, action = action })
    end

    local function osmap(os_or_list, key, modifier, action)
        local current = platform.current()

        if type(os_or_list) ~= "table" then
            if current == os_or_list then
                map(key, modifier, action)
            end
            return
        end

        for _, os in ipairs(os_or_list) do
            if current == os then
                map(key, modifier, action)
                return
            end
        end
    end

    local function unixmap(key, modifier, action)
        osmap({ OS.LINUX, OS.MAC }, key, modifier, action)
    end

    local function winmap(key, modifier, action)
        osmap(OS.WINDOWS, key, modifier, action)
    end

    return {
        keys    = keys,
        map     = map,
        unixmap = unixmap,
        winmap  = winmap,
    }
end

return M
