" Vim Syntax File
" "
" " Language:    Clingo
" " Maintainers: Jonathan Batteas <jonathan.batteas@udri.udayton.edu>
" " Created:     Jan 31st, 2019
" " Changed:     Jan 31st, 2019
" " Remark:      
" "
" " TODO:        
" "              
"
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syntax case match

syntax keyword clingoBuiltIn   not #count #even #odd #max #min #sum #maximize #minimize #show #showsig
      \ #sup #inf #true #false #forget #external #cumulative #disjoint #const #base #include #program #hide

syntax cluster clingoBuiltIn      contains=clingoBuiltIn

syntax match   clingoArithmetic   /\*\*\?\|+\|\/\/\?\|\/\\\|<<\|>>\|\\\/\?\|\^/
      \ contained containedin=clingoBody

syntax match   clingoRelations    /=\.\.\|!\|=:=\|=\?<\|=@=\|=\\=\|>=\?\|@=\?<\|@>=\?\|\\+\|\\\?=\?=\|\\\?=@=\|=/
      \ contained containedin=clingoBody

syntax region  clingoCComment     fold start=/%\\*/ end=/\\*%/ contains=clingoTODO
syntax match   clingoComment      /%.*/ contains=clingoTODO
syntax region  clingoCommentFold  fold start=/^\zs\s*%/ skip=/^\s*%/ end=/^\ze\s*\([^%]\|$\)/ contains=clingoComment
syntax keyword clingoTODO         FIXME TODO fixme todo Fixme FixMe Todo ToDo XXX xxx contained
syntax cluster clingoComments     contains=clingoCComment,clingoComment,clingoCommentFold

syntax region  clingoBody         fold start=/\(:-\|?-\)/ end=/\./
      \ contains=@clingoAll,clingoPredicateWithArity
syntax region  clingoDCGBody      fold start=/-->/ end=/\./
      \ contains=@clingoAll,clingoDCGSpecials

syntax match   clingoNumber       /\<\d\+\>/ contained
syntax match   clingoNumber       /\<\d\+\.\d\+\>/ contained
syntax match   clingoAtom         /\<\l\w*\>\ze\([^(]\|$\)/ contained
syntax match   clingoVariable     /\<\(_\|\u\)\w*\>/ contained

syntax match   clingoHead         /\<\l\w*\>/ nextgroup=clingoBody,clingoDCGBody skipwhite
syntax region  clingoHeadWithArgs start=/\<\l\w*\>(/ end=/)/ nextgroup=clingoBody,clingoDCGBody contains=@clingoAll

syntax match  clingoOpStatement   /indexed\|discontiguous\|dynamic\|module_transparent\|multifile\|volatile\|initialization/
      \ containedin=clingoBody contained

syntax region  clingoDCGSpecials  start=/{/ end=/}/ contained contains=@clingoAll

syntax region  clingoTuple        fold start=/\W\zs(/ end=/)/ contained containedin=clingoPredicate,clingoBody contains=@clingoAll
syntax region  clingoPredicate    start=/\<\l\w*\>\ze(/ end=/)/ contains=@clingoAll
syntax match   clingoPredicateWithArity /\<\l\w*\>\/\d\+/ contains=@clingoBuiltIn,clingoArity
syntax match   clingoArity        contained /\/\d\+/
syntax cluster clingoPredicates   contains=clingoPredicate,clingoPredicateWithArity

syntax region  clingoList         start=/\[/ end=/\]/ contains=clingoListDelimiters,@clingoAll,clingoPredicateWithArity contained
syntax match   clingoListDelimiters /[,|]/ contained

syntax cluster clingoAll          contains=clingoList,clingoPredicate,clingoTuple,@clingoTerms,@clingoComments,clingoQuoted,@clingoBuiltIn,clingoRelations,clingoArithmetic,clingoDiffList
syntax cluster clingoTerms        contains=clingoVariable,clingoAtom,clingoList,
      \clingoNumber,clingoErrorTerm

syntax match   clingoQuotedFormat /\~\(\d*[acd\~DeEgfGiknNpqrR@st\|+wW]\|`.t\)/ contained
syntax region  clingoQuoted       start=/'/ end=/'/ skip=+\\'+ contains=clingoQuotedFormat,@Spell

syntax match   clingoErrorVariable /\<\(_\|\u\)\w*\>/
syntax region  clingoErrorTerm    start=/\<\(_\|\u\)\w*\>(/ end=/)/

"" Highlights

highlight link clingoErrorVariable Error
highlight link clingoErrorTerm     Error

highlight link clingoOpStatement  Preproc
highlight link clingoComment      Comment
highlight link clingoCComment     Comment
highlight link clingoTODO         TODO

highlight link clingoAtom         Constant
highlight link clingoVariable     Identifier
highlight link clingoNumber       Number

highlight link clingoBuiltIn   Keyword

highlight link clingoRelations    Statement

highlight link clingoQuotedFormat Special
highlight link clingoQuoted       String

highlight link clingoPredicate    Normal
highlight link clingoPredicateWithArity Normal
highlight link clingoHead         Constant
highlight link clingoHeadWithArgs Normal

highlight link clingoBody         Statement
highlight link clingoDCGBody      Statement

highlight link clingoList         Type
highlight link clingoListDelimiters Type
highlight link clingoArity        Type
highlight link clingoDCGSpecials  Type
highlight link clingoTuple        Type
highlight link clingoDiffList     Type

syn sync minlines=20 maxlines=50

let b:current_syntax = "clingo"

