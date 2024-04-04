-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.api.nvim_set_hl(0, "Normal", { bg = "none", fg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = "none" })

local opt = vim.opt

opt.showmode = true -- Dont show mode since we have a statusline
opt.spelllang = { "en", "pt_BR" }
opt.wrap = true
opt.scrolloff = 8
opt.updatetime = 500
