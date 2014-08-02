"===================================================================================
"  DESCRIPTION:  Settings that load only for files with the .css extension
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
