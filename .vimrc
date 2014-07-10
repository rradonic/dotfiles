" basics

set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

set nowrap
set hidden
set history=1000
set ignorecase

set nowrapscan
set incsearch

set fileformats+=mac
set nrformats-=octal

set laststatus=2
set shortmess+=I
set wildmode=longest,list

set autoindent
set smarttab
set shiftround
set shiftwidth=4
set tabstop=4

set mouse=a
set clipboard=unnamedplus

set ttimeout
set ttimeoutlen=100

set foldmethod=indent
set foldlevel=1000
set diffopt=foldcolumn:0

set iskeyword+=-
set complete-=i

filetype plugin on
autocmd BufEnter * :syntax sync fromstart
set synmaxcol=0

runtime! macros/matchit.vim

let g:loaded_matchparen=1
let g:netrw_list_hide= '\./$,\.\./$'
let g:netrw_banner=0

" keyboard mappings

function! CurrentHighlight()
  let highlightGroup = synIDattr(synID(line("."), col("."), 1), "name")
  let transparentGroup = synIDattr(synID(line("."), col("."), 0), "name")
  let translatedGroup = synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")

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

let mapleader=","
let maplocalleader=";"

nnoremap Y y$
" nnoremap j I
" nnoremap k A

nnoremap <f2> :echo CurrentHighlight()<cr>
nnoremap <f3> qq
nnoremap <f4> q
nnoremap <f5> @q
nnoremap <f8> :set hlsearch!<cr>
nnoremap <f9> :b #<cr>
nnoremap <f12> :call GrepFind()<cr>

nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :%s:\v::gcI<left><left><left><left><left>
xnoremap <leader>r :s:\v::gcI<left><left><left><left><left>
nnoremap <leader>m zz
nnoremap <leader>t zt
nnoremap <leader>c :botright cwindow<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>N :cprevious<cr>
nnoremap <leader>g :g:\v:<left>

noremap <leader><home> ^
" noremap p "0p

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

" visual stuff

set listchars=tab:  ,trail:+,extends:-,precedes:-,nbsp:+
set fillchars=vert: 

function! BufWinEnterCallback()
  if &modifiable
    setlocal list
    setlocal colorcolumn=100
  else
    setlocal nolist
    setlocal colorcolumn=0
  endif
endfunction

autocmd BufWinEnter * :call BufWinEnterCallback()
autocmd BufWinEnter * :call BufWinEnterCallback()

hi cursorline cterm=none
hi tabline cterm=none
hi todo ctermbg=8 ctermfg=4
hi colorcolumn ctermbg=0
hi search ctermbg=5 ctermfg=7
" hi incsearch cterm=none ctermbg=5 ctermfg=7

hi visual ctermbg=0 cterm=none
hi visualnos ctermbg=0 cterm=none

hi statusline ctermbg=7 ctermfg=0 cterm=none
hi statuslinenc ctermbg=7 ctermfg=0 cterm=bold
hi vertsplit ctermfg=7

hi diffadd ctermbg=6 ctermfg=15
hi diffchange ctermbg=0 ctermfg=15
hi diffdelete ctermbg=8 ctermfg=0
hi difftext ctermbg=5 ctermfg=15

hi folded ctermbg=0
hi foldcolumn ctermbg=0

" plugins

call pathogen#infect()

hi ctrlpmode1 ctermbg=7 ctermfg=0
hi ctrlpmode2 ctermbg=7 ctermfg=0
hi ctrlpstats ctermbg=7 ctermfg=0

let g:ctrlp_lazy_update = 1
