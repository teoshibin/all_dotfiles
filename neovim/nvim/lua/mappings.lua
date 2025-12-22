
local function map(modes, lhs, rhs, opts)
    opts = opts or {}
    local default_opts = { noremap = false }
    opts = vim.tbl_deep_extend("force", default_opts, opts)
    vim.keymap.set(modes, lhs, rhs, opts)
end

-- Escape
map("i", "jj", "<Esc>", { desc = "Quick Escape" })
map(
    "n", "<Esc>",
    function() return (vim.v.hlsearch == 1) and "<Cmd>nohlsearch<CR><Esc>" or "<Esc>" end,
    { expr = true, silent = true, replace_keycodes = true, desc = "No hightlight and escape" }
)

-- Repeat Command
map("n", "<leader>.", "@@", { desc = "General Repeat last marco" })

-- Quickfix List
map("n", "[q", "<cmd>cprevious<CR>", { desc = "Quickfix Previous quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Quickfix Next quickfix" })

-- Navigate panes
map("t", "<C-l>", "<C-\\><C-n><C-w><C-l>")
map("t", "<C-h>", "<C-\\><C-n><C-w><C-h>")
map("t", "<C-k>", "<C-\\><C-n><C-w><C-k>")
map("t", "<C-j>", "<C-\\><C-n><C-w><C-j>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-j>", "<C-w><C-j>")

-- New Line
map("n", "<leader>o", 'o<Esc>0"_D', { desc = "General Add newline below" })
map("n", "<leader>O", 'O<Esc>0"_D', { desc = "General Add newline above" })

-- Reslect Indented Lines
map("v", ">", ">gv", { desc = "Visual line indent right" })
map("v", "<", "<gv", { desc = "Visual line indent left" })

-- Centered Jump
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Centered Stack Jump
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

-- Centered Find
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Centered Function Jump
map("n", "[m", "[mzz")
map("n", "]m", "]mzz")

-- Paste on top
map("v", "p", "pgvy")

