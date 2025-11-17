require("config.lazy")

vim.g.firenvim_config = {
    localSettings = {
        [".*?leetcode.com.*"] = { takeover = "always" },
        [".*"] = { takeover = "never" }
    }
}
vim.g.firenvim_config.localSettings['.*'] = { cmdline = 'neovim' }

vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>call firenvim#focus_page()<CR>", {})
vim.api.nvim_set_keymap("n", "<C-z>", "<Cmd>call firenvim#hide_frame()<CR>", {})
vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})
