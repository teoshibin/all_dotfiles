
local autocmd = vim.api.nvim_create_autocmd

-- auto vert split help doc
autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.cmd("wincmd L")
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight when copying text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

