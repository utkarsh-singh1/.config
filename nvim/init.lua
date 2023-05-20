--[[ 

███╗   ██╗███████╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝   ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                    
]]
 

local cmd = vim.cmd

--- Setup
require "nexvim/options" 
require "nexvim/lualine"
require "nexvim/nvimtree"
require "nexvim/autopairs"
require "nexvim/keymaps"
require "nexvim/plugin"
require "nexvim/bufferline"
require "nexvim/lspconfig"

--- Themes
-- require "nexvim/Themes/gruvbox"
require "nexvim/Themes/onedark"
-- require "nexvim/Themes/catppuccin"
-- require "nexvim/Themes/tokyonight"
-- require "nexvim/Themes/dracula"

















-- COC
cmd "let g:coc_global_extension = [ 'coc-emmet', 'coc-go', 'coc-html', 'coc-eslint', 'coc-git', 'coc-json', 'coc-pyright', 'coc-tsserver', 'coc-prettier', 'coc-yaml']"





                                      
