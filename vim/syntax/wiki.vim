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

func! Foldexpr_markdown(lnum)
    let l1 = getline(a:lnum)
    if l1 =~ '^\s*$'
        " ignore empty lines
        return '='
    endif
    let l2 = getline(a:lnum+1)
    if  l2 =~ '^==\+\s*'
        " next line is underlined (level 1)
        return '>1'
    elseif l2 =~ '^--\+\s*'
        " next line is underlined (level 2)
        return '>2'
    elseif l1 =~ '^#'
        " current line starts with hashes
        return '>'.matchend(l1, '^#\+')
    elseif a:lnum == 1
        " fold any 'preamble'
        return '>1'
    else
        " keep previous foldlevel
        return '='
    endif
endfunc

setlocal foldexpr=Foldexpr_markdown(v:lnum)
setlocal foldmethod=expr
