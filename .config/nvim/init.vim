" vim:foldmethod=marker foldlevel=0

" Plugins {{{
" automatic vim plug install
if empty(glob('~/.share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" file navigation
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/vista.vim'

" theming
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'

" indent lines
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'

" vim classics
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'

" workspace & buffers manager
Plug 'qpkorr/vim-bufkill'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tmux
Plug 'christoomey/vim-tmux-navigator'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" marks
Plug 'kshenoy/vim-signature'

" comments
Plug 'preservim/nerdcommenter'

" emmet
Plug 'mattn/emmet-vim'

" lsp
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'uiiaoo/java-syntax.vim'
Plug 'norcalli/nvim-colorizer.lua'

" linter
Plug 'dense-analysis/ale'

" focus
Plug 'junegunn/goyo.vim'
call plug#end()
" }}}

" Sane settings {{{
set backspace=indent,eol,start
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent
set hlsearch incsearch
set scrolloff=3 sidescrolloff=5
set ignorecase smartcase
set showmode
set history=1000
set relativenumber number
set linebreak
set splitbelow
set mouse=a
set autoread
set encoding=utf-8

let mapleader="\<space>"
" }}}
" ALE {{{
let g:ale_disable_lsp=1
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'java': ['google_java_format'],
\  'typescriptreact': ['eslint', 'prettier'],
\  'json': ['prettier']
\}
let g:ale_java_javac_executable = "javac -cp ~/.m2/repository/org/projectlombok/lombok/1.18.12/lombok-1.18.12.jar"

nnoremap <F2> :ALEFix<cr>
" }}}
" coc.nvim {{{
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gj <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>af  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <bslash>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <bslash>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <bslash>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <bslash>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <bslash>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <bslash>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <bslash>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <bslash>p  :<C-u>CocListResume<CR>
" }}}
" CtrlSpace {{{
if has('win32')
    let s:vimfiles = '~/vimfiles'
    let s:os   = 'windows'
else
    let s:vimfiles = '~/.vim'
    if has('mac') || has('gui_macvim')
        let s:os = 'darwin'
    else
    " elseif has('gui_gtk2') || has('gui_gtk3')
        let s:os = 'linux'
    endif
endif

let g:CtrlSpaceFileEngine = s:vimfiles . '/plugged/vim-ctrlspace' . '/bin/file_engine_' . s:os . '_amd64'

if executable("rg")
  let g:CtrlSpaceGlobCommand = 'rg -l --color=never -g "" .'
endif

let g:CtrlSpaceDefaultMappingKey = "<C-space> "
" }}}
" Emmet {{{
let g:user_emmet_leader_key=','
" }}}
" fzf {{{
" easy fzf call
nnoremap <leader>o :Files<cr>

" easy ripgrep call, don't match file names
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
nnoremap <leader>R :Rg<cr>

" fzf-preview default config
nmap <Leader>F [fzf-p]
xmap <Leader>F [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>
" }}}
" NERDCommenter {{{
let g:NERDSpaceDelims = 1
" }}}
" NERDTree {{{
" hide the signcolumn coc needs on normal buffers
autocmd FileType nerdtree setlocal signcolumn=no

" https://github.com/Yggdroot/indentLine/issues/152
autocmd BufEnter NERD_tree* :LeadingSpaceDisable
let g:NERDTreeWinSize = 50
let g:NERDTreeWinPos = "right"
let NERDTreeMinimalUI = 1

" easy nerd tree toggle
map <leader>n :NERDTreeToggle<cr>
nnoremap <F1> :NERDTreeFind<cr>
" }}}
" Sane bindings {{{
" easy system clipboard copy/paste ; nvim needs a clipboard provider
noremap <leader>y "+y
noremap <leader>Y "+Y
noremap <leader>p "+p
noremap <leader>P "+P

" easy window navigation
nnoremap <a-h> gT
nnoremap <a-l> gt
nnoremap <c-s-tab> gT
nnoremap <c-tab> gt
nnoremap <leader>- <c-w>s
nnoremap <c-n> <c-w>n
nnoremap <leader><bar> <c-w>v

" easy buffer manipulation
nnoremap <leader>_ <c-w>_<c-w><bar>
nnoremap <leader>= <c-w>=
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>

" easy reloading
nnoremap <F5> :source $XDG_CONFIG_HOME/nvim/init.vim<cr>

" clear the search help buffer when hitting return
nnoremap <leader><cr> :nohlsearch<cr>

" center the search matches
nnoremap n nzz
nnoremap N Nzz

" copied from https://github.com/lervag/dotvim/blob/master/vimrc
" Utility maps for repeatable quickly change/delete current word
nnoremap c*   *``cgn
nnoremap c#   *``cgN
nnoremap cg* g*``cgn
nnoremap cg# g*``cgN
nnoremap d*   *``dgn
nnoremap d#   *``dgN
nnoremap dg* g*``dgn
nnoremap dg# g*``dgN

" easy buffer clear
nnoremap Q :BD<cr>
" }}}
" Startify {{{
let g:startify_change_to_vcs_root = 1
let g:startify_custom_header =
      \ 'startify#center(startify#fortune#cowsay())'
" easy startify
nnoremap <leader>st :Startify<cr>
" }}}
" Theming {{{
set background=dark
set termguicolors
colorscheme gruvbox

" hide those ugly ~
highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_tab_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:indentLine_char = '▏'
let g:indentLine_fileTypeExclude = [ 'startify' ]

" hex code 
lua require'colorizer'.setup()

" }}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" easy snippets
nnoremap <leader>es :UltiSnipsEdit!<cr>
" }}}
" Vista {{{
" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" easy vista
nnoremap <leader>v :Vista!!<cr>
" }}}
