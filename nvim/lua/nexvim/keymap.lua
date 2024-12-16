local global = vim.g
local keymap = vim.api.nvim_set_keymap

global.mapleader = " "

-- terminal and Floaterm
keymap('t', '<esc>', '<C-\\><C-n>',{noremap = true})
keymap('n', '<C-n>', ':FloatermToggle<CR>', {noremap = true})
keymap('n', '<leader>n', ':FloatermNew --height=0.5 --width=1.0 --position=bottomright --wintype=float<CR>', {noremap = true})
keymap('n', '<leader>N', ':FloatermNew --height=1.0 --width=1.0 --position=topright --wintype=float<CR>', {noremap = true})
keymap('n', '<leader>l', ':FloatermNew --height=1.0 --width=0.6 --position=topright --wintype=float<CR>', {noremap = true})
