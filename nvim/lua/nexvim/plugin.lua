--[[
    ██████  ██      ██    ██  ██████  ██ ███    ██ 
    ██   ██ ██      ██    ██ ██       ██ ████   ██ 
    ██████  ██      ██    ██ ██   ███ ██ ██ ██  ██ 
    ██      ██      ██    ██ ██    ██ ██ ██  ██ ██ 
    ██      ███████  ██████   ██████  ██ ██   ████ 


--]]



--- Plugin - packer
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  
  -- Theme
  use {'luisiacc/gruvbox-baby', branch = 'main'}
  --use "olimorris/onedarkpro.nvim"
  use 'navarasu/onedark.nvim'
  use 'Mofiqul/dracula.nvim'
  use { "ellisonleao/gruvbox.nvim" }
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'folke/tokyonight.nvim'
  use 'rmehri01/onenord.nvim'
  use({
  "folke/styler.nvim",
  config = function()
    require("styler").setup({
      themes = {
        markdown = { colorscheme = "gruvbox" },
        help = { colorscheme = "catppuccin-mocha", background = "dark" },
      },
    })
  end,
})

  
  -- Terminal
  use 'voldikss/vim-floaterm'
  
  -- AutoCompletion and LSP 
  use {'neoclide/coc.nvim', branch = 'release'}
  use "neovim/nvim-lspconfig"
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- Autopairs
  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

 -- tabline
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

 -- Nvim-tree
 use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  tag = 'nightly' 
}

 
  -- telescope
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

end)

