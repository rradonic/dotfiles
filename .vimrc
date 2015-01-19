" basics

call pathogen#infect()

source $HOME/.vim/bundle/vim-sensible/plugin/sensible.vim

set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

set noshowcmd
set nowrap
set hidden
set ignorecase
set nowrapscan

set shortmess+=I
set wildmode=longest,list

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

set listchars=tab:  ,trail:+,extends:-,precedes:-,nbsp:+

filetype indent off

autocmd BufEnter * :syntax sync fromstart
set synmaxcol=0

set regexpengine=1
" set lazyredraw

let g:loaded_matchparen=1
let g:loaded_netrw=1

" let g:netrw_list_hide= '\./$,\.\./$'
" let g:netrw_banner=0
" let g:netrw_dirhistmax=0

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

  if empty(pathPattern)
    execute 'grep -Eir ' .
      \ shellescape(searchPattern) . ' ' .
      \ fnameescape(startingDirectory)
  else
    execute 'grep -Ei ' .
      \ shellescape(searchPattern) . ' `find ' .
      \ fnameescape(startingDirectory) . ' -type f -ipath ' .
      \ shellescape(pathPattern) . '`'
  endif
endfunction

let mapleader = "\<space>"
let maplocalleader = "\<backspace>"

nnoremap Y y$

nnoremap <f2> :echo CurrentHighlight()<cr>
nnoremap <f3> qq
nnoremap <f4> q
nnoremap <f5> @q
nnoremap <f9> :b #<cr>
nnoremap <f8> :set hlsearch!<cr>
nnoremap <f12> :call GrepFind()<cr>

nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :%s:\v::gcI<left><left><left><left><left>
xnoremap <leader>r :s:\v::gcI<left><left><left><left><left>
nnoremap <leader>m zz
nnoremap <leader>t zt
nnoremap <leader>c :botright cwindow<cr>
nnoremap <leader>l :botright lwindow<cr>
nnoremap <leader>g :g:\v:<left>

" noremap <leader><home> ^

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

" visual stuff

set fillchars=vert: ,diff: 

function! BufWinEnterCallback()
  setlocal list
  setlocal conceallevel=0

  " let match=matchstr(bufname('%'), 'COMMIT_EDITMSG')

  " if &modifiable && empty(match)
  "   setlocal colorcolumn=100
  " else
  "   setlocal colorcolumn=0
  " endif
endfunction

autocmd BufWinEnter * :call BufWinEnterCallback()

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

hi! link todo comment

" colors for the solarized theme

" hi cursorline cterm=none
" hi tabline cterm=none

" hi search ctermbg=6 ctermfg=7
" hi error ctermfg=1 ctermbg=none
" hi! link todo comment

" hi statusline cterm=reverse
" hi statuslinenc ctermbg=7 cterm=reverse

" hi diffadd ctermbg=2 ctermfg=7
" hi diffdelete ctermbg=1 ctermfg=7
" hi diffchange ctermbg=3 ctermfg=15
" hi difftext ctermbg=6 ctermfg=15

" plugins

hi ctrlpmode1 ctermfg=none ctermbg=0
hi ctrlpmode2 ctermfg=none ctermbg=0
hi ctrlpstats ctermfg=none ctermbg=0

let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_lazy_update = 1

hi signcolumn ctermbg=0

hi syntasticwarningsign ctermbg=0 ctermfg=3
hi syntasticstylewarningsign ctermbg=0 ctermfg=3
hi syntasticerrorsign ctermbg=0 ctermfg=1
hi syntasticstyleerrorsign ctermbg=0 ctermfg=1

let g:syntastic_enable_signs = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
