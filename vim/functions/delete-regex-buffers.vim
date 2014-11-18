"===============================================================================
" DESCRIPTION:   Delete buffers from buffer list matching regex
" EXAMPLE USAGE: Assuming we have [text1.md, text2.md, text3.md] buffers open.
"                We can delete buffers text2.md and text3.md like so
"                `:BD 2\|3`
"                There are delete because the regex `2\|3` matches the desired
"                buffer names
"===============================================================================
function! DeleteMatchingBuffers(pattern)
    let l:bufferList = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let l:matchingBuffers = filter(bufferList, 'bufname(v:val) =~ a:pattern')
    if len(l:matchingBuffers) < 1
        echo 'No buffers found matching pattern ' . a:pattern
        return
    endif
    exec 'bd ' . join(l:matchingBuffers, ' ')
endfunction

command! -nargs=1 BD call DeleteMatchingBuffers('<args>')

"===============================================================================
" Function Keymappings
"===============================================================================
" N/A

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
" N/A
