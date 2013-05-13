" basics

set mouse=ar
set nowrap
set autoindent
set laststatus=2
set shortmess+=I
set wildmode=longest,list
set scrolljump=-50
set clipboard=unnamedplus
set history=1000
set hidden
set iskeyword+=-
set relativenumber

set notimeout
set ttimeout
set ttimeoutlen=100

set incsearch
set nowrapscan

set foldmethod=indent
set foldlevel=1000

filetype plugin on
autocmd BufEnter * :syntax sync fromstart

" these two enable syntax highlighting for files opened with 'args'
autocmd! BufWinEnter,WinEnter * nested if exists('syntax_on') && ! exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') == -1 | syntax enable | endif
autocmd! BufRead * if exists('syntax_on') && exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') != -1 | unlet! b:current_syntax | endif

let g:loaded_matchparen=1
runtime! macros/matchit.vim

set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" keyboard shortcuts

let mapleader=","
let maplocalleader=";"

nnoremap Y y$
nnoremap <f2> :echo "uhi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
nnoremap <silent> <f3> qq
nnoremap <silent> <f4> @q
nnoremap <silent> <f8> :set hlsearch!<cr>
nnoremap <silent> <f9> :b #<cr>
nnoremap <space> za
nnoremap <f12> :grep -ir 
nnoremap <leader>s /\c
nnoremap <leader>S ?\c
nnoremap <leader>r :%s:\v::gc<left><left><left><left>
vnoremap <leader>r :s:\v::gc<left><left><left><left>
nnoremap <leader>m :argdo %s:\v::ge<left><left><left><left>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

noremap <silent> h b
noremap <silent> l w
nnoremap <silent> j a
nnoremap <silent> k A

" default indentation

set expandtab
set shiftwidth=2
set softtabstop=2

" visual stuff

set listchars=tab: \ ,trail:-,extends:>,precedes:<,nbsp:+
autocmd BufEnter * :set list
set fillchars=vert: ,fold:-

hi cursorline cterm=none
hi tabline cterm=none
hi todo ctermbg=0 ctermfg=4

hi statusline ctermbg=7 ctermfg=0 cterm=none
hi statuslinenc ctermbg=7 ctermfg=0 cterm=bold
hi vertsplit ctermfg=7

hi linenr ctermfg=0 cterm=bold

hi diffadd ctermbg=2 ctermfg=15
hi diffchange ctermbg=5 ctermfg=15
hi diffdelete ctermbg=1 ctermfg=1
hi difftext ctermbg=6 ctermfg=15

hi folded ctermbg=0 ctermfg=0 cterm=bold
hi foldcolumn ctermbg=0

" plugin configuration

let g:bufExplorerShowRelativePath=1

" load plugins

call pathogen#infect()
