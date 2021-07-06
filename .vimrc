filetype off

set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim

" Brief help for Vundle
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'

  " NerdTree plugins
  Plugin 'scrooloose/nerdtree'
  "Plugin 'Xuyuanp/nerdtree-git-plugin'
  Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

  " Airline plugins
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'tpope/vim-fugitive'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'matze/vim-move'
  Plugin 'Yggdroot/indentLine'
  Plugin 'Raimondi/delimitMate'
  Plugin 'ctrlpvim/ctrlp.vim'
  Plugin 'vim-scripts/BufOnly.vim' " plugin that closes all buffers except buffer in focus
  Plugin 'udalov/kotlin-vim'
  Plugin 'tpope/vim-commentary'
  Plugin 'haishanh/night-owl.vim'

  " Clojure support
  "Plugin 'guns/vim-clojure-static'
  "Plugin 'tpope/vim-fireplace'
  "Plugin 'tpope/vim-salve'
  "Plugin 'clojure-vim/async-clj-omni' " autocomplete for Clojure
 
  " Android support
  Plugin 'hsanson/vim-android'

  " Autocompolete
  if has('nvim')
    Plugin 'shougo/deoplete.nvim'
  else
    " requires 'python-msgpack' and 'pynvim' packages on host
    Plugin 'shougo/deoplete.nvim'
    Plugin 'roxma/nvim-yarp'
    Plugin 'roxma/vim-hug-neovim-rpc'
  endif

call vundle#end()

" Enable 24bit true color for theme night-owl
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 " 24bit color support for Alacritt
 let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
 let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

 set termguicolors
endif

syntax on
filetype plugin indent on

" Enable deoplete autocomplete
let g:deoplete#enable_at_startup = 1

" Always show statusline
set laststatus=2

set tabstop=4
set shiftwidth=4
set smartindent
set autoindent

" Use spaces instead of tabs
set expandtab

set backspace=2
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set ruler
set history=128
set undolevels=2048
set pastetoggle=<F10>
set ttimeoutlen=10
set background=dark

set termencoding=utf-8
set fileencoding=utf-8
set encoding=utf-8

" Disable swapfile
set noswapfile

" Splits open at the bottom and right
set splitbelow splitright

" Enable ralative line numbers
set number

colo night-owl
" colo gruvbox
" colo xoria256
" colo iceberg
" colo abstract

" Fix background in tmux
set t_ut=

" map <S-Tab> <C-w>w
" map <S-PageUP> :bn<CR>
" map <S-PageDown> :bp<CR>

" Open NerdTree plugin
nnoremap <C-n> :NERDTreeToggle<CR>

" Remap { and } for quick buffer switching
nnoremap } :bn<CR>
nnoremap { :bp<CR>

" Remap Ctrl+O to close all buffers except buffer in focus
nnoremap <C-o> :BufOnly<CR>

" Remap copying to system clipboard
map <F5> "+y

" Remap :tag and :po commands (jump to tag and go back)
nnoremap gd <C-]>
nnoremap gb :po<CR>

" Split line by symbol ','
nnoremap gs f,lxi<CR>l

" Remap '[m'(previous method) and ']m'(next method) to 'H' and 'L'
nnoremap H [mzz
nnoremap L ]mzz

" Remap gn to :noh (hide highlight)
nnoremap gn :noh<CR>

" Make cursor thinner in INSERT mode
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Airline
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':t'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '  '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '  '
let g:airline_symbols.branch = '=>'
let g:airline_symbols.readonly = '*'
let g:airline_symbols.linenr = '+'
let g:airline_symbols.notexists = '*'

" NERDTree
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

let NERDTreeShowHidden=1

call NERDTreeHighlightFile('md', 'blue', 'none', 'blue', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow','#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('erb', 'red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('slim', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'blue', 'none', 'blue', '#151515')
call NERDTreeHighlightFile('rb', 'red', 'none', 'red', '#151515')

" NERDTree git
let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "*",
  \ "Staged"    : "+",
  \ "Untracked" : "~",
  \ "Renamed"   : ">",
  \ "Unmerged"  : "=",
  \ "Deleted"   : "x",
  \ "Dirty"     : "!",
  \ "Clean"     : "0",
  \ "Unknown"   : "?"
  \ }

" vim-move
let g:move_key_modifier = 'C'

" indentLine: prevent from hiding elements in markdown
let g:indentLine_conceallevel = 0

" Path to Android SDK
let g:android_sdk_path = '/home/aleksey/bin/android-sdk'

" Configure CtrlP plugin for large projects
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_clear_cache_on_exit=0
