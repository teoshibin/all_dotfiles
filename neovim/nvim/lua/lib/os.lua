
local M = {}

local uname = vim.loop.os_uname()
local sys = uname.sysname or ""
local release = uname.release or ""

local is_mac = sys == "Darwin"
local is_linux = sys == "Linux"
local is_windows = sys:match("Windows") ~= nil
local is_wsl = is_linux and release:match("Microsoft") ~= nil

function M.name()
    return sys
end

function M.isMac()
    return is_mac
end

function M.isLinux()
    return is_linux
end

function M.isWindows()
    return is_windows
end

function M.isWSL()
    return is_wsl
end

return M
