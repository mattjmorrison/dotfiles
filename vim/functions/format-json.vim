"===============================================================================
" DESCRIPTION:   Nicely format long single line json strings
" EXAMPLE USAGE: Visually select an uglified json string and call this command
"                to pretty print it
"===============================================================================
function! FormatJSON()
    :'<,'>!python -m json.tool
endfunction
command! -range FormatJSON call FormatJSON()

"===============================================================================
" Function Keymappings
"===============================================================================
" N/A

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
" N/A
