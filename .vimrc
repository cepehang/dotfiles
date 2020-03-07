call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  } }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'
call plug#end()

set background=dark
colorscheme gruvbox

cd ~
set backspace=indent,eol,start
set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab autoindent
set hlsearch incsearch
set scrolloff=3
set ignorecase smartcase
set showmode
set history=1000
set relativenumber number
set linebreak
set splitbelow
set autochdir

syntax on
let NERDTreeShowHidden=1

" easy system clipboard copy/paste ; nvim needs a clipboard provider
noremap <space>y "*y
noremap <space>Y "*Y
noremap <space>p "*p
noremap <space>P "*P

" easy window navigation
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <a-h> gT
nnoremap <a-l> gt
nnoremap <c-s-tab> gT
nnoremap <c-tab> gt
nnoremap <c-n> <c-w>n

" easy window resizing
nnoremap <space>_ <c-w>_
nnoremap <space>= <c-w>=

" easy resourcing
nnoremap <F5> :source $HOME/.vimrc<cr>

" command line shortcuts
nnoremap <space>q :q<cr>
nnoremap <space>w :w<cr>
nnoremap <space>x :x<cr>
nnoremap <space>n :NERDTreeToggle<cr>
nnoremap <space>t :terminal<cr>

" clear the search help buffer when hitting return
nnoremap <space><cr> :nohlsearch<cr>

" unimpaired mappings
inoremap <c-bs> <c-w>
nnoremap <space>O O<esc>
nnoremap <space>o o<esc>
