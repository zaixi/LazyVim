-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- This file is automatically loaded by plugins.init
-- 创建自动命令 {{{
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

--vim.api.nvim_create_autocmd("BufEnter", {
--  callback = function()
--    whichkey_checkduplicates()
--  end,
--})

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
--vim.api.nvim_create_autocmd("InsertEnter", {
--  callback = function()
--    vim.opt.relativenumber = true
--  end,
--})
--
--vim.api.nvim_create_autocmd("InsertLeave", {
--  callback = function()
--    vim.opt.relativenumber = false
--  end,
--})
--
---- File extension specific tabbing
--vim.api.nvim_create_autocmd("Filetype", {
--  group = augroup("python_tab"),
--  pattern = "python",
--  callback = function()
--    vim.opt_local.expandtab = true
--    vim.opt_local.tabstop = 4
--    vim.opt_local.shiftwidth = 4
--    vim.opt_local.softtabstop = 4
--  end,
--})
