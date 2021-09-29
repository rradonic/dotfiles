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
Plug 'w0rp/ale'

Plug 'vimwiki/vimwiki'

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

set expandtab
set shiftwidth=2
set softtabstop=2

set mouse=a

set clipboard=unnamedplus

" set foldmethod=indent
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

nnoremap j <nop>
xnoremap j <nop>
onoremap j <nop>
nnoremap k <nop>
xnoremap k <nop>
onoremap k <nop>
nnoremap <c-s> <c-n>
xnoremap <c-s> <c-n>
onoremap <c-s> <c-n>
nnoremap <c-x> <c-n>
xnoremap <c-x> <c-n>
onoremap <c-x> <c-n>

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
nnoremap <f2> :echo CurrentHighlight()<cr>

nnoremap Y y$
xnoremap gp "_d"0P
nnoremap <silent> du :diffupdate<cr>

nnoremap <f3> qq
nnoremap <f4> q
nnoremap <f5> @q

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
nnoremap <leader>f :set foldlevel=
nnoremap <leader>F :set foldlevel=100<cr>
nnoremap <leader>d <c-^>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

nnoremap <silent> <leader>p :FZF<cr>
nnoremap <silent> <leader>b :Buffers<cr>

" autocmds

function! SetSyntax()
  syntax sync fromstart
  set synmaxcol=0
  set maxmempattern=100000
endfunction

function! ShowConcealed()
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

" for vim-indent-object, include line above as well as line below indented region

function! UseLinesAround()
  vmap ai aI
  omap ai aI
endfunction

augroup autocmd_group
  autocmd!
  autocmd FileType * setlocal formatoptions-=o
  autocmd FileType * :call SetSyntax()
  autocmd FileType * :call UseLinesAround()
  autocmd FileType,BufRead * :call ShowConcealed()
  autocmd FileType,BufRead * :call HighlightConflictMarkers()
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

if executable("rg")
  let &grepprg='rg -i --vimgrep --no-heading ' . $RG_FILTER_SERIALIZED
  set grepformat=%f:%l:%c:%m
endif

let g:fzf_layout = { 'down': '12' }
let g:fzf_preview_window = ''

let g:vimwiki_conceallevel=0

autocmd BufRead,BufNewFile *.js.erb set filetype=javascript
