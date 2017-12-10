"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basics

call pathogen#infect()

source $HOME/.vim/bundle/vim-sensible/plugin/sensible.vim

set t_Co=8

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

" set scrolloff=5
" set sidescrolloff=5

set shortmess+=I
set wildmode=longest,list

" filetype indent off
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

set regexpengine=1

let g:loaded_matchparen=1
let g:loaded_netrw=1

" set lazyredraw

let find_command = 'find . -type f -not -path ''*/.git/*'' -not -path ''*/log/*'' -not -path ''*/tmp/*'' -not -path ''*/coverage/*'''

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

function! GrepFind(find_command)
  let searchPattern = input('Search pattern: ')
  if empty(searchPattern) | return | endif

  let pathPattern = input('Path pattern: ')
  if empty(pathPattern) | return | endif

  let cmd = a:find_command . ' | grep ' .
    \ shellescape(pathPattern) .
    \ ' | xargs grep -Ein '.
    \ shellescape(searchPattern)

  cexpr system(cmd)
endfunction

" let mapleader = "\<space>"
" let maplocalleader = "\<backspace>"

nnoremap Y y$

nnoremap <silent> <f2> :echo CurrentHighlight()<cr>
nnoremap <silent> <f3> qq
nnoremap <silent> <f4> q
nnoremap <silent> <f5> @q
nnoremap <silent> <f9> <c-^>
nnoremap <silent> <f12> :call GrepFind(find_command)<cr>

nnoremap <silent> <leader>m zz
nnoremap <silent> <leader>t zt
nnoremap <silent> <leader>c :botright cwindow<cr>
nnoremap <silent> <leader>C :cclose<cr>
nnoremap <silent> <leader>l :botright lwindow<cr>
nnoremap <silent> <leader>L :botright lclose<cr>
nnoremap <silent> <leader>h :set hlsearch!<cr>
nnoremap <silent> <leader>. :let @+ = expand("%")<cr>

nnoremap <leader>s /\v
nnoremap <leader>r :%s:\v::gcI<left><left><left><left><left>
xnoremap <leader>r :s:\v::gcI<left><left><left><left><left>
nnoremap <leader>g :g:\v:<left>
nnoremap <leader>v :v:\v:<left>
nnoremap <leader>f :set foldlevel=

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '@'

nnoremap <silent> <leader>p :call fzf#run({'source': find_command, 'sink': 'e', 'down': '10'})<cr>
nnoremap <silent> <leader>b :call fzf#run({'source': map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'), 'sink': 'e', 'down': '10'})<cr>

nnoremap <backspace> :

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

" let g:ctrlp_custom_ignore = '\v\.git\/|logs?\/|tmp\/|coverage\/'
" let g:ctrlp_max_files = 0
" let g:ctrlp_working_path_mode = 'r'
" let g:ctrlp_lazy_update = 1

    " let g:syntastic_always_populate_loc_list = 1
    " " let g:syntastic_auto_loc_list = 1
    " " let g:syntastic_check_on_open = 1
    " let g:syntastic_check_on_wq = 0
    " let g:syntastic_enable_signs = 0
    " let g:syntastic_enable_highlighting = 1

" let g:syntastic_cpp_compiler = 'g++'
" let g:syntastic_cpp_compiler_options = ' -std=c++14 -Wall -Wextra -Werror -pedantic'

let g:ale_set_highlights = 0
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
