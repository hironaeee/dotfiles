" dein flag {{{
let s:use_dein = 1
" }}}

" Prepare .vim dir {{{
let s:vimdir = $HOME . '/.vim'
if has('vim_starting')
  if ! isdirectory(s:vimdir)
    call system('mkdir ' . s:vimdir)
  endif
endif
" }}}

" dein {{{

" check/prepare dein environment {{{
let s:dein_enabled = 0
if v:version > 704 && s:use_dein && !filereadable(expand('~/.vim_no_dein'))
  let s:git = system('which git')
  if strlen(s:git) != 0
    " Set dein paths
    let s:dein_dir = s:vimdir . '/dein'
    let s:git_server = 'github.com'
    let s:dein_repo_name = 'Shougo/dein.vim'
    let s:dein_repo = 'https://' . s:git_server . '/' . s:dein_repo_name
    let s:dein_github = s:dein_dir . '/repos/' . s:git_server
    let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

    " Check dein has been installed or not.
    if !isdirectory(s:dein_repo_dir)
      let s:is_clone = confirm('Prepare dein?', "Yes\nNo", 2)
      if s:is_clone == 1
        let s:dein_enabled = 1
        echo 'dein is not installed, install now '
        echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
        call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
        if v:version == 704
          call system('cd ' . s:dein_repo_dir . ' && git checkout -b 1.5 1.5' )
        endif
      endif
    else
      let s:dein_enabled = 1
    endif
  endif
endif
" }}} check/prepare dein environment

" Begin plugin part {{{
if s:dein_enabled
  let &runtimepath = &runtimepath . ',' . s:dein_repo_dir
  let g:dein#install_process_timeput = 600

  " Check cache
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " dein
    " Do not manage dein at Vim 7.4, as it is not HEAD
    if v:version != 704
      call dein#add('Shougo/dein.vim')
    endif

    " Completion {{{
    if ((has('nvim') || has('timers')) && has('python3')) && system('pip3 show neovim') !=# ''
      call dein#add('Shougo/deoplete.cvim')
      if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
      endif
    endif
    " }}}

    " View {{{
    " Status line
    call dein#add('itchyny/lightline.vim')
    " }}}
    
    " Syntac Checking
    if has('nvim') || (has('job') && has('channel') && has('timers'))
      call dein#add('w0rp/ale')
    endif

    call dein#end()

    call dein#save_state()
  endif

  " Installation check
  if dein#check_install()
    call dein#install()
  endif
endif

" }}} dein


" Basic settings {{{

" mapleader (<Leader>) (default is \)
let g:mapleader = ','
" use \, as , instead
noremap <Subleader> <Nop>
map <Space> <Subleader>
nnoremap <Subleader>, ,
xnoremap <Subleader>, ,

if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
endif

" lightline.vim {{{
let g:lightline={
  \ 'colorscheme': 'solarized'
  \ }
set laststatus=2
set t_Co=256
" }}} lightline.vim

" ale {{{
if s:dein_enabled && dein#tap('ale')
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
endif
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
set foldlevel=0
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

" swap files
set swapfile
set nobackup
set nowritebackup
