call plug#begin('~/.local/share/nvim/site/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'

Plug 'michaeljsmith/vim-indent-object'

packadd cfilter

call plug#end()

source $HOME/.local/share/nvim/site/plugged/vim-sensible/plugin/sensible.vim

set scrolloff=0
set sidescrolloff=1

set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

set exrc
set secure

set ignorecase
set nowrapscan
set nohlsearch

set matchpairs+=<:>
set iskeyword+=-

let g:loaded_matchparen=1
let g:loaded_netrw=1

nnoremap j <nop>
xnoremap j <nop>
onoremap j <nop>
nnoremap k <nop>
xnoremap k <nop>
onoremap k <nop>
" nnoremap <c-s> <c-n>
" xnoremap <c-s> <c-n>
" onoremap <c-s> <c-n>
nnoremap <c-x> <c-n>
xnoremap <c-x> <c-n>
onoremap <c-x> <c-n>

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
nnoremap <f2> :echo CurrentHighlight()<cr>

nnoremap Y y$

nnoremap <leader>g :grep ''<left>
xnoremap <leader>g y :grep -F '<C-r>"'
" xnoremap <leader>g y:grep -F '<C-r>"'
" nnoremap <leader>w yiw:grep <c-r>"
nnoremap <leader>m zz
nnoremap <leader>t zt
nnoremap <leader>T zt<c-y><c-y><c-y><c-y><c-y>
nnoremap <silent> <leader>c :botright cwindow<cr>
nnoremap <silent> <leader>l :botright lwindow<cr>
nnoremap <silent> <leader>o :let @+ = expand("%")<cr>

nnoremap <leader>r :%s/\V/gcI<left><left><left><left>
xnoremap <leader>r :s/\V/gcI<left><left><left><left>
nnoremap <leader>d <c-^>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

nnoremap <silent> <leader>b :Buffers<cr>
