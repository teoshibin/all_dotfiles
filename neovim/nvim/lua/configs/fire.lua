
-- NOTE: Do not name this file as firenvim, it causes the browser extension to crash.

if vim.g.started_by_firenvim == true then
    local g = vim.g
    local api = vim.api

    g.firenvim_config = {
        localSettings = {
            [".*?leetcode.com.*"] = { takeover = "always" },
            [".*"] = { takeover = "never" }
        }
    }
    g.firenvim_config.localSettings['.*'] = { cmdline = 'neovim' }

    api.nvim_set_keymap( "n", "<Esc><Esc>", "<Cmd>call firenvim#focus_page()<CR>", {})
    api.nvim_set_keymap( "n", "<C-z>", "<Cmd>call firenvim#hide_frame()<CR>", {})
end

