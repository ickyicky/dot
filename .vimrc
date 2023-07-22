" Doman vimrc 

set nocompatible              " required by Vundle
set encoding=utf-8            " for better polish letters
set number relativenumber     " relative number - gamechanger
set clipboard=unnamedplus     " to yank into clipboard easily
set ignorecase smartcase      " set search to case insensitive
set undofile
filetype off                  " required by Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" add all your plugins here
" VERY IMPORTANT
" BEFORE YOU INSTALL PLUGINS YOU NEED TO HAVE VIM PLUGGED
" PLUGIN MENAGER. TO INSTALL IT CLONE IT TO .vim/autoload/plug.vim:
"       VIM_PLUG_INSTALL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
"       curl -fLo ~/.vim/autoload/plug.vim --create-dirs ${VIM_PLUG_INSTALL}
"       vim +PlugInstall +qall

call plug#begin()
Plug 'sainnhe/edge'
Plug 'preservim/nerdtree'
Plug 'chriskempson/base16-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'dense-analysis/ale'
call plug#end()

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin"
    set mouse=a
    set alt_send_esc=true
  endif
endif
" ...

" All of your Plugins must be added before the following line
filetype plugin indent on    " required

" leader
let mapleader = ","

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

" better fold
let g:SimpylFold_docstring_preview=1

" Python syntax highlighting
let python_highlight_all=1
syntax on

" Theme config
" set termguicolors
let base16colorspace=256
colorscheme base16-ocean

" nerdtree settings
let NERDTreeIgnore=['\.pyc$', '\~$']

" FZF configuration
nnoremap <C-p> :Files<Cr>
nnoremap <C-o> :Rg<CR>

" open FZF if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | execute 'NERDTree' | wincmd l | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | execute 'NERDTree' argv()[0] | wincmd l  | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" cursor
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" KEYBINDINGS AND MAPS
" <Ctrl-s> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-s> :nohl<CR><C-l>

" keybinding for nerdtree
map <C-n> :NERDTreeToggle<CR>

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
" ALE config
let g:ale_linters = {
			\ 'python': ['pyls', 'flake8', 'mypy'],
			\ 'cs': ['OmniSharp'],
			\}

let g:ale_fixers = {
			\ '*': ['trim_whitespace'],
			\ 'python': ['black'],
			\ 'css': ['prettier'],
			\ 'scss': ['prettier'],
			\ 'html': ['prettier'],
			\ 'javascript': ['prettier'],
			\ 'json': ['prettier'],
			\ 'php': ['prettier'],
			\ 'yaml': ['prettier'],
			\}

" ale completion is really annoying
let g:ale_completion_enabled = 0
let g:ale_completion_tsserver_autoimport = 0
let g:ale_set_highlights = 0
let g:ale_disable_lsp = 1

" ALE
nmap <silent> <F5> <Plug>(ale_previous_wrap)
nmap <silent> <C-F5> <Plug>(ale_next_wrap)
