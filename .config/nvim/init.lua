require('plugins')
require('helpers')
require('nvtree')
require('lightline')
require('vim-markdown')
require('lsp')
require('autocompletion')
require('conjure')

set_vim_options({
  { key = 'background', value = 'dark' },

  -- Indentation
  { key = 'backspace', value = 'indent,eol,start' },
  { key = 'tabstop', value = '4' },
  { key = 'shiftwidth', value = '4' },
  { key = 'smartindent' },
  { key = 'autoindent' },
  { key = 'expandtab' },
  { key = 'showtabline', value = '2' }, -- ???

  -- Searching
  { key = 'showmatch' },
  { key = 'hlsearch' },
  { key = 'ignorecase' },
  { key = 'incsearch' },
  { key = 'smartcase' },

  -- 
  { key = 'splitbelow' },
  { key = 'splitright' },

  -- Encoding
  { key = 'termencoding', value = 'utf-8' },
  { key = 'fileencoding', value = 'utf-8' },
  { key = 'encoding', value = 'utf-8' },

  -- Disable sounds
  { key = 't_vb', value = '' },
  { key = 'visualbell' },
  { key = 'noerrorbells' },

  -- Fix background in tmux
  { key = 't_ut', value = '' },

  -- Add clipboard support
  -- { key = 'clipboard', value = 'unnamedplus' },

  -- Others
  { key = 'ruler' },
  { key = 'history', value = '256' },
  { key = 'undolevels', value = '2048' },
  { key = 'pastetoggle', value = '<F10>' },
  { key = 'ttimeoutlen', value = '10' },
  { key = 'laststatus', value = '2' },
  { key = 'number' },
  { key = 'statusline', value = '%m%2F%2r%=[%l/%L:%c]%4y' },
  { key = 'termguicolors'},
})

map_key_bindings({
  { key = '<S-Tab>', command = '<C-w>w' },
  { key = '<S-UP>', command = ':tabnew<CR>' },
  { key = 'gt', command = ':NvimTreeToggle<CR>' },
  { key = '<C-p>', command = ':Files<CR>' },

  -- Remap { and } for quick buffer switching
  { key = '{', command = ':bp<CR>' },
  { key = '}', command = ':bn<CR>' },

  -- Remap gn to :noh (hide highlight)
  { key = 'gn', command = ':noh<CR>' },

  -- Remap gw to :bd (delete buffer)
  { key = 'gw', command = ':bd<CR>' },

  -- Remap gy to clipboard
  { mode = 'v', key = 'gy', command = '"+y' },

  -- Remap gyl to copy line
  { key = 'gl', command = '^v$h"+y' },
  
  -- Coment/uncomment
  -- { key = 'gc', command = ':Commentary<CR>' },
  
  -- Open urls under the cursor
  { key = 'go', command = ':!open <cWORD>' },

  -- Delete all
  { key = 'dia', command = 'gg^dG<CR>' },

  -- Remap :tag and :po commands (jump to tag and go back)
  { key = 'gd', command = '<C-]>' },
  { key = 'gb', command = ':po<CR>' },

  -- Split line by symbol ','
  { key = 'gs', command = 'f,lxi<CR>l' },

  -- Remap '[m'(previous method) and ']m'(next method) to 'H' and 'L'
  { key = 'H', command = '[mzz' },
  { key = 'L', command = ']mzz' },

  -- Resize windows
  { key = '<C-l>', command = ':vert resize +10%<CR>' },
  { key = '<C-h>', command = ':vert resize -10%<CR>' },
  
  -- Move lines up and down
  { mode = 'n', key = '<C-j>', command = ':m .+1<CR>' },
  { mode = 'n', key = '<C-k>', command = ':m .-2<CR>' },
  { mode = 'i', key = '<C-j>', command = '<Esc>:m .+1<CR>gi' },
  { mode = 'i', key = '<C-k>', command = '<Esc>:m .-2<CR>gi' },
  { mode = 'v', key = '<C-j>', command = ":m '>+1<CR>gv" },
  { mode = 'v', key = '<C-k>', command = ":m '<-2<CR>gv" },

  -- Telescope commands
  { key = '<C-n>', command = ':Telescope find_files<CR>' },
  { key = '<C-p>', command = ':Telescope live_grep<CR>' },
  { key = '<C-t>', command = ':Telescope help_tags<CR>' },
})

vim.api.nvim_command('colorscheme night-owl')
-- vim.api.nvim_command('colorscheme monokai_pro')
