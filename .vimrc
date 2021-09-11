call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'

Plug 'michaeljsmith/vim-indent-object'

Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'

if v:version >= 800
  Plug 'w0rp/ale'
end

packadd cfilter

call plug#end()

source $HOME/.vim/plugged/vim-sensible/plugin/sensible.vim

set laststatus=1
set scrolloff=0
set sidescrolloff=1

set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

set exrc
set secure

set noshowcmd
set nowrap
set hidden
set ignorecase
set nowrapscan
set nohlsearch
set textwidth=99

set shortmess+=I
set wildmode=longest,list

filetype indent off
set expandtab
set shiftwidth=2
set softtabstop=2

set mouse=a

set clipboard=unnamedplus

set foldmethod=indent
set foldlevel=1000
set diffopt=filler,foldcolumn:0,context:2147483647,vertical

set matchpairs+=<:>
set iskeyword+=-

set listchars+=tab:  
set fillchars=vert: 

let g:loaded_matchparen=1
let g:loaded_netrw=1

set lazyredraw
set number
set signcolumn=yes
" set colorcolumn=100

nnoremap j <nop>
xnoremap j <nop>
onoremap j <nop>
nnoremap k <nop>
xnoremap k <nop>
onoremap k <nop>
nnoremap <c-s> <c-n>
xnoremap <c-s> <c-n>
onoremap <c-s> <c-n>

if has('nvim')
  " colorscheme desert
  set guicursor=
else
  " set t_Co=8
  set ttymouse=xterm2
  set cryptmethod=blowfish
end

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

nnoremap <backspace> :

nnoremap Y y$
" nnoremap gY "py$
" xnoremap gy "py
" onoremap gy "py
" nnoremap D "pD
" xnoremap d "pd
" onoremap d "pd

xnoremap gp "_d"0P
nnoremap <silent> du :diffupdate<cr>

nnoremap <f3> qq
nnoremap <f4> q
nnoremap <f5> @q

nnoremap <leader>g :grep ''<left>
nnoremap <leader>w yiw:grep <c-r>"
nnoremap <leader>m zz
nnoremap <leader>t zt
nnoremap <leader>T zt<c-y><c-y><c-y><c-y><c-y>
nnoremap <silent> <leader>c :botright cwindow<cr>
nnoremap <silent> <leader>l :botright lwindow<cr>
nnoremap <silent> <leader>o :let @+ = expand("%")<cr>

nnoremap <leader>r :%s/\V/gcI<left><left><left><left>
xnoremap <leader>r :s/\V/gcI<left><left><left><left>
nnoremap <leader>f :set foldlevel=
nnoremap <leader>F :set foldlevel=100<cr>
nnoremap <leader>d <c-^>
nnoremap <leader>Cr :cfdo %s///g <bar> update<left><left><left><left><left><left><left><left><left><left><left><left>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

nnoremap <silent> <leader>p :FZF<cr>
nnoremap <silent> <leader>b :Buffers<cr>

" autocmds

function! SetSyntax()
  syntax sync fromstart
  set synmaxcol=0
  set maxmempattern=100000
endfunction

function! VisibilityCallback()
  setlocal list
  setlocal conceallevel=0
endfunction

function! HighlightConflictMarkers()
  if &ft ==# 'help'
    return
  end

  silent! call matchdelete(9999)
  silent! call matchdelete(9998)
  silent! call matchdelete(9997)

  call matchadd('error', '^<<<<<<<.*', -1, 9999)
  call matchadd('error', '^=======.*', -1, 9998)
  call matchadd('error', '^>>>>>>>.*', -1, 9997)
endfunction

augroup autocmd_group
  autocmd!
  autocmd FileType * setlocal formatoptions-=o
  autocmd FileType * :call SetSyntax()
  autocmd FileType,BufRead * :call VisibilityCallback()
  " autocmd FileType,BufRead * :call HighlightConflictMarkers()
augroup END

" plugin config

let g:ale_linters_explicit = 1
let g:ale_set_signs = 1
let g:ale_set_highlights = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'css': ['stylelint'],
\   'eruby': [],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'ruby': ['rubocop'],
\   'scss': ['stylelint'],
\}

let g:ale_fixers = {
\   'css': ['prettier'],
\   'go': ['gofmt'],
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'json': ['prettier'],
\   'ruby': ['rubocop'],
\   'scss': ['prettier', 'stylelint'],
\}

let g:jsx_ext_required = 0

let g:rg_options = "-g '!db/data/*' -g '!**/vendor/*' -g '!**/fonts/*' -g '!spec/dummy/*' -g '!*.lock'"

if executable("rg")
  let &grepprg='rg -i --vimgrep --no-heading ' . g:rg_options
  set grepformat=%f:%l:%c:%m
endif

let $FZF_DEFAULT_COMMAND = 'rg --files --sort-files ' . g:rg_options
let g:fzf_layout = { 'down': '12' }
let g:fzf_preview_window = ''

au BufRead,BufNewFile *.js.erb set filetype=javascript
