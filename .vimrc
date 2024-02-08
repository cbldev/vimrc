" Disable Vi-compat mode
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  PLUGINS                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
  " Installs vim-plug if not already installed
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""
"  WHOLE EDITOR PLUGINS  "
""""""""""""""""""""""""""

" onedark.vim
Plug 'joshdick/onedark.vim'

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" Git
Plug 'tpope/vim-fugitive'

" Rails engine
Plug 'tpope/vim-rails'

" File system explorer
Plug 'preservim/nerdtree'

" Full path finder
Plug 'ctrlpvim/ctrlp.vim'

" Distraction-free writing
Plug 'junegunn/goyo.vim'

" Visual block
Plug 'mg979/vim-visual-multi'

" GitHub Copilot
Plug 'github/copilot.vim'

" Tabby
"Plug 'TabbyML/vim-tabby'

call plug#end() " required

"""""""""""""""""""""""""""""
"  ENABLE SYNTAX & PLUGINS  "
"""""""""""""""""""""""""""""

" Required. Enables plugins and proper indentation.
filetype plugin indent on

" Enable syntax highlighting
syntax enable

" Configure onedark colorscheme
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1

colorscheme onedark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  SETTINGS                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""
"  SANE DEFAULTS  "
"""""""""""""""""""

" Show line numbers
set number
" Show line & char position
set ruler
" Copy indent from previous line
set autoindent
" Do smart autoindenting when starting a new line.
set smartindent
" Use spaces instead of tabs
set expandtab
" Related to above
set smarttab
" Show us which mode we're in
set showmode
" Show us what command we're plugging in
set showcmd
" Size of a tab in spaces
set tabstop=2
" Number of spaces used for autoindent
set shiftwidth=2
" Update a file if changes outside of Vim
set autoread

" Don't redraw the window until ready
set lazyredraw

" Highlight the matching bracket when we insert a new one.
set showmatch
" But only for 2 seconds
set mat=2

" Don't create a spare file, clogs up Git if not configured properly
set noswapfile

" Use comma as the leader
let mapleader=","

" Encode in UTF-8
set encoding=utf8
" Support all file endings
set ffs=unix,dos,mac

" Fix backspace not working
set backspace=indent,eol,start

" Don't hard wrap the text
set nowrap

" Always show the status line
set laststatus=2

""""""""""""""""""""
"  REMAPPING KEYS  "
""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" NERDTree
map <C-t> :NERDTreeToggle<cr>
map <C-f> :NERDTreeFind<cr>

" Goyo
map <C-z> :Goyo<cr>

" Git
map <leader>gs :Git status<cr>
map <leader>ga :Git add -p<cr>
map <leader>gc :Git commit -m ""

"""""""""""""""""""""
"  SEARCH SETTINGS  "
"""""""""""""""""""""

" Highlight all search matches
set hlsearch
" Ignore case when searching
set ignorecase
" Unless we have a capital letter
set smartcase
" Add magic characters to search
set magic
" Disable highlight when // is pressed
map <silent> // :noh<CR>

""""""""""""""""""""""
"  HELPER FUNCTIONS  "
""""""""""""""""""""""

" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Strip trailing whitespace on write
autocmd BufWritePre * call <SID>StripTrailingWhitespaces()

""""""""""""""""""
" SET LINEBREAKS "
""""""""""""""""""

set wrap
set linebreak

