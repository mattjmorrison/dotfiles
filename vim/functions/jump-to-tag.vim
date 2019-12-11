"===============================================================================
" DESCRIPTION:   If we are in a python file call jedi goto on the word under
"                the cursor if any other file type attempt to jump to the ctag
"                definition for the word under the cursor.
" EXAMPLE USAGE: Position cursor over a word and press <leader>gt
"===============================================================================
function! MyJumpTo()
    let filetype=&ft
    if filetype == "python"
        exe ":call jedi#goto_definitions()"
    else
        :exe "norm \<C-]>"
    endif
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>gt :call MyJumpTo()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Jump to ctag or word under the cursor                         <Leader>gt', 'normal <Leader>gt']]
