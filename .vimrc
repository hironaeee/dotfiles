" Vim 8 defalut.vim
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

"augroup vimrc
  "autocmd!
"augroup END


" VIM-PLUG {{{

silent! if plug#begin('~/.vim/plugged')

" Color Schemes
Plug 'tomasr/molokai'
Plug 'cocopon/iceberg.vim'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

let s:python3_dir = $HOME . '/.lsp_servers/pyls-all/venv'
if isdirectory(s:python3_dir)
  let s:ret = system('source ' . s:python3_dir . '/bin/activate && pip show pynvim && echo $?')
  if s:ret != 0
    call system('source ' . s:python3_dir . '/bin/activate && pip install pynvim')
  endif
  let g:python3_host_prog = s:python3_dir . '/bin/python'
endif
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'lighttiger2505/deoplete-vim-lsp'
  Plug 'w0rp/ale'
endif

" tmux config
Plug 'christoomey/vim-tmux-navigator'

Plug 'itchyny/lightline.vim'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'thinca/vim-quickrun'

call plug#end()
endif

" }}} VIM-PLUG


" Plugin Settings {{{

" lightline.vim {{{
let g:lightline={
  \ 'colorscheme': 'solarized'
  \ }
set laststatus=2
set t_Co=256
" }}} lightline.vim

" ale {{{
let g:ale_lint_on_enter = 0
let g:ale_sign_column_always = 1

nnoremap [ale] <Nop>
nmap <Leader>a [ale]
nmap <silent> [ale]p <Plug>(ale_previous)
nmap <silent> [ale]n <Plug>(ale_next)
nmap <silent> [ale]a <Plug>(ale_toggle)
nmap <silent> [ale]l :ALEList<CR>

function! s:ale_list()
  let g:ale_open_list = 1
  call ale#Queue(0, 'lint_file')
endfunction
command! ALEList call s:ale_list()

"autocmd MyAutoGroup FileType qf nnoremap <silent> <buffer> q :let g:ale_open_list = 0<CR>:q!<CR>
"autocmd MyAutoGroup FileType help,qf,man,ref let b:ale_enabled = 0

" Disable automatic check at file open/close
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" C++
let g:syntastic_cpp_check_header = 1
" }}} ale

" deoplete.nvim {{{
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" }}} deoplete.nvim

" ctrlp {{{
" ignore files written in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" }}} ctrlp

" vim-quickrun {{{
let g:quickrun_config = {
  \ '*' : {
  \   'outputter/buffer/split': ':botright 10sp',
  \   'hook/time/enable': 1
  \   },
  \ }
" }}} vim-quickrun

""" {{{ vim-lsp-settings
let g:lsp_settings_servers_dir = $HOME . '/.vim/lsp_servers'
" }}} vim-lsp-settings

" }}} Plugin Settings


" Basic Settings {{{

" folding
set foldmethod=marker
set foldlevel=0
set foldlevelstart=99

" mapleader (<Leader>) (default is \)
let g:mapleader = "\<Space>"

" file encoding
set encoding=utf-8
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
set fileformats=unix,dos,mac

" display style
set textwidth=0
set ruler
set number
syntax on
" color
hi LineNr ctermfg=7 guifg=Grey
hi Comment ctermfg=7 guifg=Grey
hi Visual ctermbg=7 guibg=Grey
hi Pmenu ctermbg=7 guibg=Grey
hi PmenuSel ctermbg=14 guibg=LightBlue

" edit settings
set backspace=indent,eol,start

" search settings
set incsearch
set hlsearch
set ignorecase

" tab settings
set expandtab
set tabstop=2       " width of <Tab> in view
set shiftwidth=2    " width for indent
set softtabstop=0   " disable softtabstop
set autoindent      " autoindent
set smartindent     " do indent by checking previous line

" commandline settings
set wildmenu

"set commentstring=\ #\ %s
set scrolloff=5

" key binding
inoremap jk <ESC>

" search command
nnoremap <silent> <Esc><Esc> :noh<CR>

" swap
let s:vimdir = $HOME . '/.vim'
if ! isdirectory(s:vimdir)
  call system('mkdir ' . s:vimdir)
endif
let s:swapdir = s:vimdir . '/swap'
if ! isdirectory(s:swapdir)
  call system('mkdir -p ' . s:swapdir)
endif
let &directory = s:swapdir
set swapfile
set nobackup
set nowritebackup

" undo
if has('persistent_undo')
  let s:undodir = s:vimdir . '/undo'
  let &undodir = s:undodir
  if ! isdirectory(s:undodir)
    call system('mkdir ' . s:undodir)
  endif
  set undofile
  set undoreload=1000
endif
set undolevels=1000

" }}} Basic Settings
