"===============================================================================
" DESCRIPTION:   Write python test names like a normal sentence and then when
"                done run the function to replace the spaces with underscores
" EXAMPLE USAGE: Type a test definition with space like so
"                `def test something in a python file(test):`
"                Then press <Leader>us and it will be turned into
"                `def test_something_in_a_python_file(test):`
"===============================================================================
function! MakeUnderscore()
python3 << endPython

import vim

def underscore_test_name():
    current_line = vim.current.line
    test_start = current_line.find("test")
    test_end = current_line.find("(")
    test_name = current_line[test_start:test_end]
    test_name_underscored = test_name.replace(" ", "_")
    cursor_pos = vim.current.window.cursor
    vim.current.buffer[cursor_pos[0] - 1] = current_line.replace(test_name, test_name_underscored)

underscore_test_name()

endPython
endfunction

command! UnderscoreTest call MakeUnderscore()

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>us :call MakeUnderscore()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Undersocre Python test name                                   <Leader>us', 'normal <Leader>us']]
