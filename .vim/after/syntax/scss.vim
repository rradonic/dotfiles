source $HOME/.vim/after/syntax/css.vim

" let b:did_indent = 1

hi link sassDefinition PreProc
hi link sassMixinName Identifier
hi link scssAttribute Constant

syntax clear cssKeyFrameProp
syntax clear cssAttrRegion
syntax clear cssDefinition
syntax clear cssFontAttr

" syntax clear cssPositioningAttr
" syntax clear cssTextAttr

" syntax sync fromstart
