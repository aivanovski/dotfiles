return require('packer').startup(function()
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'airblade/vim-gitgutter'
  use 'itchyny/lightline.vim'
  use 'mengelbrecht/lightline-bufferline'
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'neovim/nvim-lspconfig'
  -- use 'rust-lang/rust.vim'
  use 'tpope/vim-fugitive'
  use 'wbthomason/packer.nvim'
  use 'vim-scripts/BufOnly.vim'
  use 'udalov/kotlin-vim'
  use 'tpope/vim-commentary'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Color themes
  use 'haishanh/night-owl.vim'
  use 'tanvirtin/monokai.nvim'

  -- Autocompletion
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Markdown support
  use 'godlygeek/tabular'
  use 'plasticboy/vim-markdown'

  -- Clojure
  use 'Olical/conjure'
end)
