" basics

call pathogen#infect()

source $HOME/.vim/bundle/vim-sensible/plugin/sensible.vim

if exists('g:big_file')
  syntax off
else
  augroup syntax_group
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
  augroup END

  set synmaxcol=0
  set maxmempattern=100000
endif

set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

set noshowcmd
set nowrap
set hidden
set ignorecase
set nowrapscan

set scrolloff=0
set sidescrolloff=1

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

  let startingDirectory = input('Starting directory: ', '', 'file')
  if empty(startingDirectory) | return | endif

  let pathPattern = input('Path pattern: ')
  if empty(startingDirectory) | return | endif

  execute 'grep -Ei ' .
    \ shellescape(searchPattern) . ' `find ' .
    \ fnameescape(startingDirectory) . ' -type f -ipath ' .
    \ shellescape(pathPattern) . '`'
endfunction

let mapleader = "\<space>"
let maplocalleader = "\<backspace>"

nnoremap Y y$

nnoremap <f2> :echo CurrentHighlight()<cr>
nnoremap <f3> qq
nnoremap <f4> q
nnoremap <f5> @q
nnoremap <f9> <c-^>
nnoremap <f8> :set hlsearch!<cr>
nnoremap <f12> :call GrepFind()<cr>

nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :%s:\v::gcI<left><left><left><left><left>
xnoremap <leader>r :s:\v::gcI<left><left><left><left><left>
nnoremap <leader>m zz
nnoremap <leader>t zt
nnoremap <leader>c :botright cwindow<cr>
nnoremap <leader>C :cclose<cr>
nnoremap <leader>l :botright lwindow<cr>
nnoremap <leader>L :botright lclose<cr>
nnoremap <leader>g :g:\v:<left>

nnoremap <leader>f :set foldlevel=

" noremap <leader><home> ^

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

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

" regular colors

hi cursorline cterm=none
hi tabline cterm=none

hi colorcolumn ctermbg=0
hi search ctermbg=5 ctermfg=7

hi visual ctermbg=0 cterm=none
hi visualnos ctermbg=0 cterm=none

hi statusline ctermbg=7 ctermfg=0 cterm=none
hi statuslinenc ctermbg=7 ctermfg=0 cterm=bold
hi vertsplit ctermfg=7

hi diffadd ctermbg=2 ctermfg=7
hi diffchange ctermbg=0 ctermfg=7
hi diffdelete ctermbg=1 ctermfg=0
hi difftext ctermbg=4 ctermfg=7

hi folded ctermbg=0
hi foldcolumn ctermbg=0

hi todo ctermbg=NONE ctermfg=4

hi linenr ctermfg=0 cterm=bold
hi cursorlinenr ctermfg=0 cterm=bold

" plugins

hi ctrlpmode1 ctermfg=none ctermbg=0
hi ctrlpmode2 ctermfg=none ctermbg=0
hi ctrlpstats ctermfg=none ctermbg=0

let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_lazy_update = 1


let g:syntastic_enable_signs = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1

" hi warningmsg ctermbg=5 ctermfg=7

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" set statusline=%<%f\ %h%m%r\ %#warningmsg#%{SyntasticStatuslineFlag()}%*\ %=%-14.(%l,%c%V%)\ %P
