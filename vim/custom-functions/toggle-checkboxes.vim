"===============================================================================
" DESCRIPTION:   Used in .md files for todo lists turns [ ] into [√] and
"                appends a done time stamp.
" EXAMPLE USAGE: Postion a cursor on a line with the following contents
"                [ ] Some todo task
"                Now press <Leader>tc and the line will be modified to the
"                following.
"                [√] Some todo task @done (10/25/14 18:17)
"===============================================================================
function! ToggleTodoCheckbox()
        let line = getline('.')
        if(match(line, "\\[ \\]") != -1)
          let line = substitute(line, "\\[ \\]", "[√]", "")
          let line = substitute(line, "$", " @done (" . strftime("%m/%d/%y %H:%M") . ")", "")
        elseif(match(line, "\\[√\\]") != -1)
          let line = substitute(line, "\\[√\\]", "[ ]", "")
          let line = substitute(line, " @done.*$", "", "")
        endif
        call setline('.', line)
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>tc :call ToggleTodoCheckbox()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += ['➤ Toggle checkbox                                              9tc', 'normal 9tc']
