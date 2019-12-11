"===============================================================================
" DESCRIPTION:   Monkeypatches the 6 search commands (/,?,n,N,*,#) and adds
"                two things. First we display a message about the number of
"                matches (i.e. "Match 3 of 12 for [searchWord]") next we
"                highlight the current match for .4 of a second to help your
"                eye track between jumps.
" EXAMPLE USAGE: Use (/, ?, n, N, *. #) as you normally would and the
"                magic happens automatically.
"===============================================================================
function! HLNext (blinktime)
    highlight HighlightStyle ctermfg=none ctermbg=160 guibg=#9D0006 cterm=none
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('HighlightStyle', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
    call matchdelete(ring)
    redraw
endfunction

function! DoIndexedSearch()
    let currentUserView = winsaveview()
    let userLine = currentUserView["lnum"]
    let userCol = currentUserView["col"] + 1
    let [totalMatches, currentMatch] = [0, -1]
    call cursor(1, 1)
    try | let [matchline, matchcol] = searchpos(@/, 'Wc') | catch | let [matchline, matchcol] = [0, 0] | endtry
    while matchline
        let totalMatches += 1
        if (matchline == userLine && matchcol == userCol)
            let currentMatch = totalMatches
        endif
        let [matchline, matchcol] = searchpos(@/, 'W')
    endwhile
    call winrestview(currentUserView)
    echo "Match " . currentMatch . " of " . totalMatches . " for" ." [" . @/ . "]"
    call HLNext(0.4)
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap /  :call DoIndexedSearch()<CR>/
nnoremap ?  :call DoIndexedSearch()<CR>?
nnoremap <silent>* *:call DoIndexedSearch()<CR>
nnoremap <silent># #:call DoIndexedSearch()<CR>
nnoremap <silent>n nzv:call DoIndexedSearch()<CR>
nnoremap <silent>N Nzv:call DoIndexedSearch()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
" N/A
