"===============================================================================
" DESCRIPTION:   Toggle the location list window open and closed
" EXAMPLE USAGE: Press <Leader>l to toggle the location list window
"===============================================================================
function! LocationListToggle(forced)
  if exists("g:llist_win") && a:forced == 0
    :lclose
  else
    :lopen
  endif
endfunction

augroup LocationListToggle
 autocmd!
 autocmd BufWinEnter quickfix let g:llist_win = bufnr("$")
 autocmd BufWinLeave * if exists("g:llist_win") && expand("<abuf>") == g:llist_win | unlet! g:llist_win | endif
augroup END

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>l :call LocationListToggle(0)<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Toggle location list                                               <Leader>l', 'call LocationListToggle()']]
