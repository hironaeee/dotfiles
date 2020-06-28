" Vim 8 defalut.vim
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

augroup vimrc
  autocmd!
augroup END

" VIM-PLUG {{{

silent! if plug#begin('~/.vim/plugged')

" Color Schemes
Plug 'tomasr/molokai'
Plug 'cocopon/iceberg.vim'

Plug 'itchyny/lightline.vim'

call plug#end()
endif

" Syntac Checking
if has('nvim') || (has('job') && has('channel') && has('timers'))
  Plug 'w0rp/ale'
endif

" Basic settings {{{

" folding
set foldmethod=marker
set foldlevel=0
set foldlevelstart=99

" mapleader (<Leader>) (default is \)
let g:mapleader = ','
" use \, as , instead
noremap <Subleader> <Nop>
map <Space> <Subleader>
nnoremap <Subleader>, ,
xnoremap <Subleader>, ,

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

" file encoding
set encoding=utf-8
" set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,default,latin
set fileformats=unix,dos,mac

" display style
set textwidth=0
set ruler
syntax on
hi Comment ctermfg=grey
set relativenumber

" edit settings
set paste
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
" exchange ':' with ';'
noremap ; :
" noremap : ;

" search command
nnoremap <silent> <Esc><Esc> :noh<CR>

" save/quit
nnoremap <A-w> :w<CR>
nnoremap <A-q> :q!<CR>
nnoremap <A-z> :ZZ<CR>
" don't enter Ex mode
nnoremap Q :q<CR>
" One characters
nnoremap Z ZZ
nnoremap W :w<CR>
nnoremap ! :q!<CR>

" Close/Close & Save buffer
nnoremap <Leader>q :bdelete<CR>
nnoremap <Leader>w :w<CR>bdelete<CR>

augroup vimrc
  autocmd FileType vim setlocal expandtab shiftwidth=2
augroup END
  
" swap files
set swapfile
set nobackup
set nowritebackup
