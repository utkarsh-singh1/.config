local cmd = vim.cmd
local set = vim.o
--[[
local lspconfig = require('lspconfig')
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local luasnip = require 'luasnip'
local cmp = require 'cmp'
--]]


require("nexvim.lazy")
require("nexvim.keymap")

-- Set Intial Options for Nvim

set.number = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 0
set.expandtab = true
set.swapfile = false
set.signcolumn = "yes"
set.smartcase = true
set.smartindent = true



