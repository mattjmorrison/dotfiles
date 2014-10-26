"===============================================================================
" DESCRIPTION:   Search from the project root recursively for a specified
"                string
" EXAMPLE USAGE: Press <Leader>a and enter the string to search for. The
"                results are displayed in the quickfix window. 
"===============================================================================
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c:%m
endif

function! TheSilverSearcher()
python << endPython

import vim

def python_input(message = 'input'):
    vim.command('call inputsave()')
    vim.command("let user_input = input('" + message + ": ')")
    vim.command('call inputrestore()')
    return vim.eval('user_input')

def silver_search():
    search_args = python_input("Search For")
    if search_args:
        vim.command('silent grep! "{}"'.format(search_args))
        vim.command('redraw!')
        vim.command('redrawstatus!')
        vim.command('copen')

silver_search()

endPython
endfunction

command Search call TheSilverSearcher()

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>a :Search<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += ['➤ Search                                                        9a', 'echo "Use 9a to start the search prompt"']
