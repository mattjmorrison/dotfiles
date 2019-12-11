"===============================================================================
" DESCRIPTION:   Given a column of the same number increment each row based on
"                the original number.
" EXAMPLE USAGE: Assuming we have the following column of numbers.
"                1
"                1
"                1
"                1
"                Visually select the numbers and then press <C-a> and the
"                numbers will be incremented to the following
"                1
"                2
"                3
"                4
"===============================================================================
function! Incr()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! '.c.'|'.a."\<C-a>"
    endif
    normal `<
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
vnoremap <C-a> :call Incr()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Increment visually selected column of numbers                 <C-a>', 'echo "Use <C-a>"']]
