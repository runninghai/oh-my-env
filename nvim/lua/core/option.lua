local g = vim.g
local opt = vim.opt

opt.clipboard="unnamed"
opt.colorcolumn='80'
opt.number=true
opt.relativenumber=true
opt.ts=4
opt.encoding='utf-8'
opt.smartindent=true
opt.shiftwidth=4
opt.expandtab=true
opt.background='dark'

-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.mapleader = '\\'

-- set termguicolors to enable highlight groups
opt.termguicolors = true

