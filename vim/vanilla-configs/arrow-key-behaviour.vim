"===============================================================================
" DESCRIPTION:   Make arrowkey resize viewports
" EXAMPLE USAGE: To resize the split by 1 use Left,Right,Up,Down
"                To resize by 50% of the split use <C-w>Left,Right,Up,Down
"===============================================================================

"===============================================================================
" Keymappings
"===============================================================================
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>
nnoremap <C-w><Right> :exe "vertical resize +" . (winwidth(0) * 1/2)<CR>
nnoremap <C-w><Left> :exe "vertical resize -" . (winwidth(0) * 1/2)<CR>
nnoremap <C-w><Up> :exe "resize +" . (winheight(0) * 1/2)<CR>
nnoremap <C-w><Down> :exe "resize -" . (winheight(0) * 1/2)<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Resize windows                                                Arrow keys', 'echo "Use the arrow keys to resize windows"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Resize windows 50%                                            <C-w>Arrow keys', 'echo "Use Ctrl-w plus the arrow keys to resize a window by 50%"']]
