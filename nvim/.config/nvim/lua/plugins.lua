vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'neovim/nvim-lspconfig'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'

  use 'tpope/vim-fugitive'

  use {
      'folke/trouble.nvim',
      config = function()
          require("trouble").setup {
              icons = false,
          }
      end
  }
  use "rafamadriz/friendly-snippets"

  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'folke/tokyonight.nvim'
end)
