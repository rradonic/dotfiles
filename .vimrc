"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basics

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'

if v:version >= 800
  Plug 'w0rp/ale'
end

call plug#end()

source $HOME/.vim/plugged/vim-sensible/plugin/sensible.vim

" set regexpengine=1

set t_Co=8
set scrolloff=0
set sidescrolloff=1
set laststatus=0

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
" set noincsearch

set shortmess+=I
set wildmode=longest,list

filetype indent off
" set shiftround
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

set cryptmethod=blowfish

set listchars+=tab:  

let g:loaded_matchparen=1
let g:loaded_netrw=1

set number

" set lazyredraw

let find_command = 'find . -regextype posix-egrep -type f
  \ -not -path ''*/.git/*''
  \ -not -path ''*/log/*''
  \ -not -path ''*/tmp/*''
  \ -not -path ''*/coverage/*''
  \ -not -path ''*/node_modules/*''
  \ -not -path ''*/public/packs/*''
  \ -not -path ''*/.keep'''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

set errorformat=./%f:%l:%m

function! Grep(find_command)
  let searchPattern = input('Search pattern: ')

  if empty(searchPattern)
    return
  endif

  let pathPattern = input('Path pattern: ')

  if empty(pathPattern)
    let pathPattern = '.*'
  else
    let pathPattern = '.*' . pathPattern . '.*'
  endif

  let cmd = a:find_command . ' -iregex ' .
    \ shellescape(pathPattern) .
    \ ' -print0 | xargs -0 grep -Eine '.
    \ shellescape(searchPattern)

  cgetexpr system(cmd)
  botright cwindow
  " echo cmd
endfunction

" let mapleader = "\<space>"
" let maplocalleader = "\<backspace>"

nnoremap <backspace> :
nnoremap Y y$

nnoremap <silent> <f2> :echo CurrentHighlight()<cr>
nnoremap <silent> <f3> qq
nnoremap <silent> <f4> q
nnoremap <silent> <f5> @q
nnoremap <silent> <f9> <c-^>
nnoremap <silent> <f12> :call Grep(find_command)<cr>

nnoremap <silent> <leader>m zz
nnoremap <silent> <leader>t zt
nnoremap <silent> <leader>c :botright cwindow<cr>
nnoremap <silent> <leader>l :botright lwindow<cr>
nnoremap <silent> <leader>h :set hlsearch!<cr>
nnoremap <silent> <leader>. :let @+ = expand("%")<cr>

nnoremap <leader>r :%s/\V/gcI<left><left><left><left>
xnoremap <leader>r :s/\V/gcI<left><left><left><left>
nnoremap <leader>g :g/\V/<left>
nnoremap <leader>v :v/\V/<left>
nnoremap <leader>f :set foldlevel=

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

nnoremap <silent> <leader>p :call fzf#run({'source': find_command, 'sink': 'e', 'down': '15'})<cr>
nnoremap <silent> <leader>b :call fzf#run({'source': map(filter(range(1, bufnr('$')), 'buflisted(v:val) && strlen(bufname(v:val)) > 0'), 'bufname(v:val)'), 'sink': 'e', 'down': '15'})<cr>

nnoremap <silent> <leader>d :call append(line('.') - 1, 'wfp')<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" visual stuff

set fillchars=vert: ,diff: 

function! VisibilityCallback()
  set list
  set conceallevel=0
endfunction

function! HighlightConflictMarkers()
  if &ft ==# 'help'
    return
  end

  syntax match conflictMarker /<<<<<<<.*/
  syntax match conflictMarker /=======.*/
  syntax match conflictMarker />>>>>>>.*/

  highlight link conflictMarker error
endfunction

function! ShowSignColumn()
  sign define dummy
  execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
endfunction

augroup visibility_group
  autocmd!
  autocmd FileType * :call VisibilityCallback()
  autocmd FileType * :call HighlightConflictMarkers()
  " autocmd FileType * :call ShowSignColumn()
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins

let g:ale_set_signs = 0
let g:ale_lint_on_text_changed = 0
let g:jsx_ext_required = 0

let g:ale_pattern_options = {
\  '.*\.erb$': {'ale_enabled': 0}
\}
