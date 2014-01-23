exec 'source $HOME/.vim/bundle/html5-syntax.vim/syntax/html/html5.vim'
exec 'source $HOME/.vim/bundle/vim-css3-syntax/after/syntax/html.vim'
exec 'source $HOME/.vim/after/syntax/javascript.vim'

setlocal expandtab shiftwidth=2 tabstop=2

setlocal commentstring=<!--%s-->

if exists("loaded_matchit")
  let b:match_ignorecase = 1
  let b:match_words = '<:>,' .
  \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
  \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
  \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif
