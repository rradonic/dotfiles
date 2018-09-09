" basics

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

if v:version >= 800
  Plug 'w0rp/ale'
end

call plug#end()

source $HOME/.vim/plugged/vim-sensible/plugin/sensible.vim

set t_Co=8
set scrolloff=0
set sidescrolloff=1
set laststatus=0

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

set shortmess+=I
set wildmode=longest,list

filetype indent off
set expandtab
set shiftwidth=2
set tabstop=2

set mouse=a
set ttymouse=xterm2
set clipboard=unnamedplus

set foldmethod=indent
set foldlevel=1000
set diffopt=filler,foldcolumn:0,context:2147483647

set matchpairs+=<:>
set iskeyword+=-

set cryptmethod=blowfish

set listchars+=tab:  
set fillchars=vert: ,diff: 

let g:loaded_matchparen=1
let g:loaded_netrw=1

set lazyredraw
set number

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

" let mapleader = "\<space>"
" let maplocalleader = "\<backspace>"

nnoremap <backspace> :
nnoremap Y y$

nnoremap <silent> <f2> :echo CurrentHighlight()<cr>
nnoremap <f3> qq
nnoremap <f4> q
nnoremap <f5> @q
nnoremap <f9> <c-^>
nnoremap <f12> :grep 

nnoremap <leader>m zz
nnoremap <leader>t zt
nnoremap <silent> <leader>c :botright cwindow<cr>
nnoremap <silent> <leader>l :botright lwindow<cr>
nnoremap <silent> <leader>o :let @+ = expand("%")<cr>

nnoremap <leader>r :%s/\V/gcI<left><left><left><left>
xnoremap <leader>r :s/\V/gcI<left><left><left><left>
nnoremap <leader>g :g/\V/<left>
nnoremap <leader>v :v/\V/<left>
nnoremap <leader>f :set foldlevel=

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

nnoremap <silent> <leader>p :call fzf#run({'sink': 'e', 'down': '15'})<cr>
nnoremap <silent> <leader>b :call fzf#run({'source': map(filter(range(1, bufnr('$')), 'buflisted(v:val) && strlen(bufname(v:val)) > 0'), 'bufname(v:val)'), 'sink': 'e', 'down': '15'})<cr>

" autocmds

function! SetSyntax()
  if line2byte(line("$") + 1) > 100000
    syntax clear
  else
    syntax sync fromstart
    set synmaxcol=0
    set maxmempattern=100000
  endif
endfunction

augroup syntax_group
  autocmd!
  autocmd FileType * :call SetSyntax()
augroup END

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

augroup visibility_group
  autocmd!
  autocmd BufRead * :call VisibilityCallback()
  autocmd BufRead * :call HighlightConflictMarkers()
augroup END

" plugin config

let g:ale_set_signs = 0
let g:ale_lint_on_text_changed = 0
let g:ale_pattern_options = {
\  '.*\.erb$': { 'ale_enabled': 0 }
\}

let g:jsx_ext_required = 0

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ -g\ '!db/data/*'\ -g\ '!**/vendor/*'\ -g\ '!**/sample-lessons/*'
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
