hi link  cssPseudoClass cssPseudoClassId

" This is for the @value feature of CSS modules
syn region valueStatement start='@value' end=';' matchgroup=valueStatement contains=valueKeyword,valueDefinition,valueFrom keepend
syn region valueDefinition start='\:' end=';' matchgroup=valueDefinition contains=valueValue contained
syn match valueValue " [^;]\{1,}" contained
syn match valueKeyword "@value" contained
syn match valueFrom "from" contained
hi link valueKeyword cssAtKeyword
hi link valueFrom cssAtKeyword
hi link valueValue constant

syntax clear cssVendor
syntax clear cssAttrComma
syntax clear cssSelectorOp

" syntax clear cssTagName
" syntax clear cssBraces
" syntax clear cssPseudoClassId
