local M = {}

local wezterm = require 'wezterm'

-- enum-like table
M.OS = {
  WINDOWS = "WINDOWS",
  MAC     = "MAC",
  LINUX   = "LINUX",
  UNKNOWN = "UNKNOWN",
}

function M.current()
  local t = wezterm.target_triple

  if t == 'x86_64-pc-windows-msvc' then
    return M.OS.WINDOWS
  elseif t == 'x86_64-apple-darwin' or t == 'aarch64-apple-darwin' then
    return M.OS.MAC
  elseif t == 'x86_64-unknown-linux-gnu' then
    return M.OS.LINUX
  else
    return M.OS.UNKNOWN
  end
end

function M.isWindows()
  return M.current() == M.OS.WINDOWS
end

function M.isMac()
  return M.current() == M.OS.MAC
end

function M.isLinux()
  return M.current() == M.OS.LINUX
end

return M
