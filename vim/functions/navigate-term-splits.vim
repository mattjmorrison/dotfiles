"===============================================================================
" DESCRIPTION:   Navigate between tmux and vim buffer splits with the same
"                keys
" EXAMPLE USAGE: Split your buffer and/or terminal (with tmux) and use Ctrl
"                plus hjkl to navigate between splits
"===============================================================================
function! s:NavigateTermSplits(direction)
  let windowNumber = winnr()
  execute 'wincmd ' . a:direction
  if windowNumber == winnr()
    " We didn't move to a new vim split. Now try to move tmux splits
    silent call system('tmux select-pane -' . tr(a:direction, 'hjkl', 'LDUR'))
  endif
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <silent> <C-h> :call <SID>NavigateTermSplits('h')<CR>
nnoremap <silent> <C-j> :call <SID>NavigateTermSplits('j')<CR>
nnoremap <silent> <C-k> :call <SID>NavigateTermSplits('k')<CR>
nnoremap <silent> <C-l> :call <SID>NavigateTermSplits('l')<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Navigate between splits                                       Ctrl + hjkl', 'echo "Use Ctrl plus hjkl to navigate splits"']]
