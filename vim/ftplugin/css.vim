"===================================================================================
"         FILE:  css.vim
"  DESCRIPTION:  Settings that load only for files with the .css extension
"       AUTHOR:  Jarrod Taylor
"===================================================================================
"

" Folds multiline css files into single line, the readability of a multiline
" with the space saving of a single line. How you going to beat that?  
function! CssFoldText()
    let line = getline(v:foldstart)
    let nnum = nextnonblank(v:foldstart + 1)
    while nnum < v:foldend+1
        let line = line . " " . substitute(getline(nnum), "^ *", "", "g")
        let nnum = nnum + 1
    endwhile
    return line
endfunction

setlocal foldtext=CssFoldText()
setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal fillchars=fold:\ 

" Alphabetize the next css property group below the cursor with <F7>. only
" does one property group at a time. Feels safer to me than doing the
" whole thing all at once.
nmap <F7> /{/+1<CR>vi{:sort<CR>
