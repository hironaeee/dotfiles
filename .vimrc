" Vim 8 defalut.vim
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

augroup vimrc
  autocmd!
augroup END

" ref: https://rcmdnk.com/blog/2020/08/11/computer-vim/
if has('nvim') && !filereadable(expand('~/.vim_no_python'))
  let s:python3 = system('which python3')
  if strlen(s:python3) != 0
    let s:python3_dir = $HOME . '/.vim/python3'
    if ! isdirectory(s:python3_dir)
      call system('python3 -m venv ' . s:python3_dir)
      call system('source ' . s:python3_dir . '/bin/activate && pip install neovim flake8 jedi')
    endif
    let g:python3_host_prog = s:python3_dir . '/bin/python'
    let $PATH = s:python3_dir . '/bin:' . $PATH
  endif
endif

" VIM-PLUG {{{

silent! if plug#begin('~/.vim/plugged')

" Color Schemes
Plug 'tomasr/molokai'
Plug 'cocopon/iceberg.vim'

Plug 'itchyny/lightline.vim'

" Syntac Checking
if has('nvim') || (has('job') && has('channel') && has('timers'))
  Plug 'w0rp/ale'
endif

" filer
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
endif

call plug#end()
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

" defx.nvim {{{
autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
   \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> t
  \ defx#do_action('open','tabnew')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('drop', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

nnoremap <silent> <Leader>f :<C-u> Defx <CR>
" }}} defx.nvim

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
