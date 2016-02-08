"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basics

call pathogen#infect()

source $HOME/.vim/bundle/vim-sensible/plugin/sensible.vim

function! SetSyntax()
  if line2byte(line("$") + 1) > 1000000
    syntax clear
  else
    syntax sync fromstart
    set synmaxcol=0
    set maxmempattern=100000
  endif
endfunction

augroup syntax_group
  autocmd!
  autocmd BufEnter * :call SetSyntax()
augroup END

set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

set noshowcmd
set nowrap
set hidden
set ignorecase
set nowrapscan

set scrolloff=0
set sidescrolloff=1

augroup scroll_group
  autocmd!
  autocmd BufEnter * :set scroll=5
augroup END

set shortmess+=I
set wildmode=longest,list

filetype indent off
set shiftround
set expandtab
set shiftwidth=2
set tabstop=2

set mouse=a
set ttymouse=xterm2
set clipboard=unnamedplus

set foldmethod=indent
set foldlevel=1000
set diffopt=filler,foldcolumn:0,context:2147483647

set iskeyword+=-
set matchpairs+=<:>

set cryptmethod=blowfish

set listchars+=tab:  

set regexpengine=1

let g:loaded_matchparen=1
let g:loaded_netrw=1

set lazyredraw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keyboard mappings

function! CurrentHighlight()
  let highlightGroup =
    \ synIDattr(synID(line("."), col("."), 1), "name")
  let transparentGroup =
    \ synIDattr(synID(line("."), col("."), 0), "name")
  let translatedGroup =
    \ synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")

  return highlightGroup . ', ' . transparentGroup . ', ' . translatedGroup
endfunction

function! GrepFind()
  let searchPattern = input('Search pattern: ')
  if empty(searchPattern) | return | endif

  let pathPattern = input('Path pattern: ')
  if empty(pathPattern) | return | endif

  let cmd = 'git ls-files | grep ' .
    \ shellescape(pathPattern) .
    \ ' | xargs grep -Ein '.
    \ shellescape(searchPattern)

  cexpr system(cmd)
endfunction

let mapleader = "\<space>"
let maplocalleader = "\<backspace>"

nnoremap Y y$

nnoremap <silent> <f2> :echo CurrentHighlight()<cr>
nnoremap <silent> <f3> qq
nnoremap <silent> <f4> q
nnoremap <silent> <f5> @q
nnoremap <silent> <f9> <c-^>
nnoremap <silent> <f12> :call GrepFind()<cr>

nnoremap <silent> <leader>p :CtrlP<cr>
nnoremap <silent> <leader>b :CtrlPBuffer<cr>
nnoremap <silent> <leader>m zz
nnoremap <silent> <leader>t zt
nnoremap <silent> <leader>c :botright cwindow<cr>
nnoremap <silent> <leader>C :cclose<cr>
nnoremap <silent> <leader>l :botright lwindow<cr>
nnoremap <silent> <leader>L :botright lclose<cr>
nnoremap <silent> <leader>h :set hlsearch!<cr>
nnoremap <silent> <leader>o :let @+ = expand("%")<cr>

nnoremap <leader>r :%s:\v::gcI<left><left><left><left><left>
xnoremap <leader>r :s:\v::gcI<left><left><left><left><left>
nnoremap <leader>g :g:\v:<left>
nnoremap <leader>f :set foldlevel=

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" visual stuff

set fillchars=vert: ,diff: 

function! VisibilityCallback()
  setlocal list
  setlocal conceallevel=0
  " setlocal indentexpr=
endfunction

augroup visibility_group
  autocmd!
  autocmd BufEnter * :call VisibilityCallback()
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins

let g:ctrlp_max_files = 0
let g:ctrlp_user_command = 'git ls-files %s'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_lazy_update = 1

let g:syntastic_enable_signs = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
