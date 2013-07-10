" basics

set nowrap
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set laststatus=2
set shortmess+=I
set wildmode=longest,list
set clipboard=unnamedplus
set history=1000
set hidden
set iskeyword+=-
set mouse=ar
set ttimeout
set ttimeoutlen=100
set ignorecase
set incsearch
set foldmethod=indent
set foldlevel=1000
filetype plugin on
autocmd BufEnter * :syntax sync fromstart
let g:loaded_matchparen=1
runtime! macros/matchit.vim

" keyboard mappings

let mapleader=","
let maplocalleader=";"
nnoremap Y y$
nnoremap <f2> :echo "uhi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
nnoremap <f3> qq
nnoremap <f4> q
nnoremap <f5> @q
nnoremap <f8> :set hlsearch!<cr>
nnoremap <f9> :b #<cr>
nnoremap <space> za
nnoremap <f12> :grep -ir<space>
nnoremap <silent> <leader>b :CtrlPBuffer<cr>
nnoremap <silent> <leader>f :CtrlP<cr>
nnoremap <leader>s /\v
nnoremap <leader>S ?\v
nnoremap <leader>r :%s:\v::gcI<left><left><left><left><left>
vnoremap <leader>r :s:\v::gcI<left><left><left><left><left>
cnoremap <expr> @ getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap k A
nnoremap j I
nnoremap <leader><home> ^
nnoremap <leader>m zz
nnoremap <leader>t zt

" visual stuff

set listchars=tab:= ,trail:-,extends:>,precedes:<,nbsp:+

autocmd BufWinEnter * if &modifiable | :set list | else | :set nolist | endif
set fillchars=vert: 
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

" load plugins

call pathogen#infect()

" plugin configuration

hi ctrlpmode1 ctermbg=0 ctermfg=15
hi ctrlpmode2 ctermbg=0 ctermfg=15
hi ctrlpstats ctermbg=0 ctermfg=15
hi ctrlpmatch ctermbg=3 ctermfg=0
