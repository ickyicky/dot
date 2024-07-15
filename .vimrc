" Doman vimrc 

set encoding=utf-8            " for better polish letters
set number relativenumber     " relative number - gamechanger
set clipboard=unnamedplus     " to yank into clipboard easily
set ignorecase smartcase      " set search to case insensitive
set undofile

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    set mouse=a
    set alt_send_esc=true
  endif
endif
" ...

" leader
let mapleader = " "

" Specify areas where screen splits
set splitbelow
set splitright
set mouse=a

" Enable folding
set foldmethod=indent
set foldlevel=99
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" PEP8 indent
au BufNewFile,BufRead *.py,*.kt,*.c,*.cpp,*.h,*.hpp,*.cs
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=0 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" 2 space indent
au BufNewFile,BufRead *.js,*.html,*.css,*.scss,*.yaml,*.yml,*.xlm,*.json
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Python syntax highlighting
let python_highlight_all=1
syntax on

" cursor
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" KEYBINDINGS AND MAPS
" <Ctrl-s> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-s> :nohl<CR><C-l>

" Enable folding with the spacebar
nnoremap <space> za

" Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

set signcolumn=yes
