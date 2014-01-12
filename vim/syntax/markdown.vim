" Make the full links only visible when we are in insert mode
set concealcursor=n

" Define the regex for out syntax highlighting group
" [[Display text][path/to/file.md]]
syntax match WikiLink /\[\[.\+|[^ ]\+\]\]/

" The conceal portion
syntax match WikiLinkLabel /\[\[.\+ <at> <=\%(|\) <at> =/ contained containedin=WikiLink
syntax match WikiLinkName /\%(|\) <at> <=[^ ]\+\]\] <at> =/ contained containedin=WikiLinkEnd
syntax match WikiLinkStart /\[\[/ conceal contained containedin=WikiLink
syntax match WikiLinkEnd /|[^ ]\+\]\]/ conceal contained containedin=WikiLink

" Highlighting for TODO's
syntax match TodoDone "@done.*$"
highlight link TodoDone String
