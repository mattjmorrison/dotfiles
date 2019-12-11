"===============================================================================
" DESCRIPTION:   Toggle the quickfix window open and closed
" EXAMPLE USAGE: Press <Leader>q to toggle the quickfix window
"===============================================================================
function! QuickfixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
  else
    execute "copen "
  endif
endfunction

augroup QuickfixToggle
 autocmd!
 autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
 autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
augroup END

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>q :call QuickfixToggle(0)<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Toggle quickfix                                               <Leader>q', 'call QuickfixToggle()']]
