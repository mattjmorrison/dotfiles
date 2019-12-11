"===============================================================================
" DESCRIPTION:   Used in .todo files for todo lists turns [ ] into [√]
"
" EXAMPLE USAGE: Postion a cursor on a line with the following contents
"                [ ] Some todo task
"                <Leader>tc will modified the line to the following:
"                [√] Some todo task
"===============================================================================
au BufNewFile,BufRead *.todo set filetype=todo
function! UpdateToDoList()
python3 << endPython

import vim

def check_row(buffer, row):
    buffer[row] = buffer[row].replace("[ ]", "[√]")

def uncheck_row(buffer, row):
    buffer[row] = buffer[row].replace("[√]", "[ ]")

def is_checked(buffer, row):
    return "√" in buffer[row]

def toggle_row(buffer, row):
    if is_checked(buffer, row):
        uncheck_row(buffer, row)
    else:
        check_row(buffer, row)

def indent_level(buffer, row):
    current_row = buffer[row]
    leading_spaces = len(current_row) - len(current_row.lstrip(' '))
    return leading_spaces / 2

def is_child(buffer, row):
    return indent_level(buffer, row) > 0

def has_children(buffer, row):
    return row + 1 < len(buffer) and indent_level(buffer, row) < indent_level(buffer, row + 1)

def get_rows_for_direction(buffer, the_range, current_indent):
    x = set()
    for n in the_range:
        if indent_level(buffer, n) >= current_indent:
            x.add(n)
        else:
            break
    return x

def get_all_current_level_and_below(buffer, row):
    current_indent = indent_level(buffer, row)
    rows_below = get_rows_for_direction(buffer, range(row, len(buffer)), current_indent)
    return rows_below | get_rows_for_direction(buffer, range(row, 0, -1), current_indent)

def check_parent(buffer, row):
    rows = get_all_current_level_and_below(buffer, row)
    check_row(buffer, min(rows) - 1)

def uncheck_parent(buffer, row):
    rows = get_all_current_level_and_below(buffer, row)
    uncheck_row(buffer, min(rows) - 1)

def set_status_of_parents(buffer, row):
    for current_row in range(0, len(buffer)):
        rows_belonging_to_parent = get_all_current_level_and_below(buffer, current_row)
        if all([is_checked(buffer, row) for row in rows_belonging_to_parent]):
            check_parent(buffer, current_row)
        elif current_row < len(buffer) and is_child(buffer, current_row):
            uncheck_parent(buffer, current_row)

def do_it():
    buffer = vim.current.buffer
    current_row = vim.current.window.cursor[0]
    if has_children(buffer, current_row - 1):
        print("Cannot toggle checkboxes with child tasks")
    else:
        toggle_row(buffer, current_row - 1)
        if is_child(buffer, current_row - 1):
            set_status_of_parents(buffer, current_row - 1)

do_it()

endPython
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>tc :call UpdateToDoList()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Toggle checkbox                                               <Leader>tc', 'normal <Leader>tc']]
