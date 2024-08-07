return require('packer').startup(function()
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'neovim/nvim-lspconfig'
  use 'wbthomason/packer.nvim'
  use 'vim-scripts/BufOnly.vim'
  use 'udalov/kotlin-vim'
  use 'tpope/vim-commentary'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/bufferline.nvim'
  use 'linrongbin16/lsp-progress.nvim'

  -- Color themes
  use 'EdenEast/nightfox.nvim'

  -- Autocompletion
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-path' -- Autocompletions for files
  use 'onsails/lspkind.nvim' -- Autoformatting suggestions in nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Markdown support
  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'

  -- Clojure
  use 'Olical/conjure'

  -- Scala
  use 'scalameta/nvim-metals'
end)
