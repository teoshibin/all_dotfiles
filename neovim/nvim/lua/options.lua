
local opt = vim.opt
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '
opt.breakindent = true
opt.undofile = true
opt.smartcase = true

opt.number = true
opt.relativenumber = true

opt.signcolumn = "number"
opt.timeoutlen = 350
opt.cursorline = true
opt.expandtab = true

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

opt.jumpoptions = "view"
opt.colorcolumn = { 120 }
opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.inccommand = "split"

opt.splitright = true
opt.splitbelow = true

opt.showmode = false
opt.showcmd = false
opt.ruler = false
vim.opt.laststatus = 3

