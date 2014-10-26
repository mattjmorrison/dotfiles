"===============================================================================
" DESCRIPTION:   Monkeypatches n and N to highlight matches for .4 of a
"                second to help your eye track between jumps
" EXAMPLE USAGE: Search for a string and use n N as you normally would and the
"                highlighting happens automatically
"===============================================================================
function! HLNext (blinktime)
    highlight HighlightStyle ctermfg=none ctermbg=160 cterm=none
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('HighlightStyle', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 500) . 'm'
    call matchdelete(ring)
    redraw
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
" N/A
