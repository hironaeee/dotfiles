" Vim 8 defalut.vim
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

"augroup vimrc
  "autocmd!
"augroup END

" ref: https://rcmdnk.com/blog/2020/08/11/computer-vim/
if !filereadable(expand('~/.vim_no_python'))
  let s:python3 = system('which python3')
  if strlen(s:python3) != 0
    let s:python3_dir = $HOME . '/.vim/python3'
    if ! isdirectory(s:python3_dir)
      call system('python3 -m venv ' . s:python3_dir)
      call system('source ' . s:python3_dir . '/bin/activate && pip install pynvim jedi')
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

" Syntax Checking
if has('nvim') || (has('job') && has('channel') && has('timers'))
  Plug 'w0rp/ale'
endif

" auto completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
elseif has('python3') && has('timers') && system('pip3 show pynvim') != ''
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'ujihisa/neco-look'
" Python auto completion plugin
Plug 'deoplete-plugins/deoplete-jedi'

" tmux config
Plug 'christoomey/vim-tmux-navigator'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'thinca/vim-quickrun'

call plug#end()
endif

" QFixHowm
set runtimepath+=~/tmp/qfixapp
let QFixHowm_key = 'g'
let howm_dir = '~/notes/howm'
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding = 'utf-8'
let howm_fileformat = 'dos'
let QFixWin_EnableMode = 1
let QFix_UseLocationList = 1

" Basic settings {{{

" folding
set foldmethod=marker
set foldlevel=0
set foldlevelstart=99

" mapleader (<Leader>) (default is \)
let g:mapleader = "\<Space>"

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
highlight Pmenu ctermbg=8 guifg=#dddd00 guibg=#1f82cd
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
"noremap ; :
" noremap : ;
inoremap jk <ESC>

" search command
nnoremap <silent> <Esc><Esc> :noh<CR>

" don't enter Ex mode
nnoremap Q :q<CR>

" Close/Close & Save buffer
nnoremap <Leader>q :bdelete<CR>
nnoremap <Leader>w :w<CR>bdelete<CR>

" swap files
set swapfile
set nobackup
set nowritebackup
