set nocompatible              " be iMproved, required
" filetype off                  " required
filetype plugin on

autocmd VimEnter * echo "F2=NT, F3=NTfind, CTRL+hjkl=Window nav, "

syntax on

" Some definitions
let mapleader=" "
nnoremap <Leader>gy :Goyo<CR>

" Disable arrow keys 
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Newline without insert, leader-j/k
nnoremap <silent> <leader>j :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>k :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" NERDTree
silent! nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" Set <Esc> to jk, remove 'Esc'
inoremap jk <Esc>
inoremap <Esc> <Nop>

" Remap the command colon
map ; :

" Numbering and cursor
set number
set relativenumber
set scrolloff=10
set cursorline
hi CursorLine term=bold cterm=bold

" For tag bar (outliner)
let g:tagbar_ctags_bin='/usr/bin/ctags'
nmap <F8> :TagbarToggle<CR>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"---------- Package Manager ----------
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"---------- Syntax -----------
Plugin 'hdima/python-syntax'
Plugin 'tomlion/vim-solidity'
Plugin 'sheerun/vim-polyglot'
Plugin 'leafgarland/typescript-vim'
au BufRead,BufNewFile *.ts   setfiletype typescript

"---------- Aesthetics -----------
" Plugin 'powerline/powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='tomorrow'
Plugin 'junegunn/goyo.vim'
let g:goyo_width=100
let g:goyo_height='100%'




"-------- Javascript --------
Plugin 'pangloss/vim-javascript' "Syntax
Plugin 'mxw/vim-jsx' "Syntax
Plugin 'leshill/vim-json' "Syntax


"---------- Python ----------
Plugin 'klen/python-mode'

"---- Markdown --------------
Plugin 'suan/vim-instant-markdown'

"---------- Tools -----------
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf' " Fuzzy file finder
Plugin 'christoomey/vim-tmux-navigator' " Window navigation

"--------- Git -------------
Plugin 'tpope/vim-fugitive'


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

