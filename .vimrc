" basics

set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

set nowrap
set hidden
set history=1000

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

set laststatus=2
set shortmess+=I
set wildmode=longest,list

set mouse=a
set clipboard=unnamedplus

set ttimeout
set ttimeoutlen=100

set incsearch
set ignorecase

set foldmethod=indent
set foldlevel=1000

set iskeyword+=-

filetype plugin on
autocmd BufEnter * :syntax sync fromstart

runtime! macros/matchit.vim

let g:loaded_matchparen=1

" keyboard mappings

let mapleader=","
let maplocalleader=";"

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

nnoremap Y y$
nnoremap k A
nnoremap j I
nnoremap <space> za

nnoremap <f2> :echo CurrentHighlight()<cr>
nnoremap <f3> qq
nnoremap <f4> q
nnoremap <f5> @q
nnoremap <f8> :set hlsearch!<cr>
nnoremap <f9> :b #<cr>
nnoremap <f12> :call GrepFind()<cr>

nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>r :%s:\v::gcI<left><left><left><left><left>
xnoremap <leader>r :s:\v::gcI<left><left><left><left><left>
nnoremap <leader>m zz
nnoremap <leader>t zt
nnoremap <leader>c :botright cwindow<cr>
nnoremap <leader>n :cnext<cr>
nnoremap <leader>N :cprevious<cr>
xnoremap <leader>p "0p
nnoremap <leader>g :g:\v:<left>

noremap <leader>s /\V
noremap <leader>S ?\V
noremap <leader><home> ^

cnoremap <expr> @ getcmdtype() == ':' ? expand('%:h').'/' : '@'

" visual stuff

set listchars=tab:  ,trail:+,extends:>,precedes:<,nbsp:+
set fillchars=vert: 

autocmd BufWinEnter * if &modifiable | :set list | else | :set nolist | endif

hi cursorline cterm=none ctermbg=0
hi tabline cterm=none
hi todo ctermbg=8 ctermfg=4
hi visual ctermbg=0 cterm=none
hi visualnos ctermbg=0 cterm=none
hi statusline ctermbg=7 ctermfg=0 cterm=none
hi statuslinenc ctermbg=7 ctermfg=0 cterm=bold
hi vertsplit ctermfg=7
hi diffadd ctermbg=6 ctermfg=15
hi diffchange ctermbg=0 ctermfg=15
hi diffdelete ctermbg=8 ctermfg=0
hi difftext ctermbg=5 ctermfg=15
hi folded ctermbg=0 cterm=bold
hi foldcolumn ctermbg=0 cterm=bold

" plugins

call pathogen#infect()

hi ctrlpmode1 ctermbg=7 ctermfg=0
hi ctrlpmode2 ctermbg=7 ctermfg=0
hi ctrlpstats ctermbg=7 ctermfg=0
hi ctrlpmatch ctermbg=3 ctermfg=0

let g:ctrlp_match_window = 'min:1,max:20'
let g:ctrlp_lazy_update = 100

let g:splice_initial_diff_grid=1
