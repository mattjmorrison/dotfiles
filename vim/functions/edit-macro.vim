"===============================================================================
" DESCRIPTION:   Edit the contents of a macro saved in the specified register
" EXAMPLE USAGE: The function will ask for a buffer than contains the macro to
"                edit. You will be presented with the contents of the buffer
"                make your edits then close the string with a ' and press
"                enter your macro has now been updated.
"===============================================================================
function! EditMacro()
  call inputsave()
  let g:regToEdit = input('Register to edit: ')
  call inputrestore()
  execute "nnoremap <Plug>em :let @" . eval("g:regToEdit") . "='<C-R><C-R>" . eval("g:regToEdit")
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nmap <Leader>em :call EditMacro()<CR> <Plug>em

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Edit macro contents in specific register                      <Leader>em', 'normal <Leader>em']]
