"===============================================================================
" Plugin source
"===============================================================================
"'osyo-manga/vim-over'

"===============================================================================
" Plugin Configurations
"===============================================================================
function! VisualFindAndReplace()
    :OverCommandLine%s/
    :w
endfunction

function! VisualFindAndReplaceWithSelection() range
    :'<,'>OverCommandLine s/
    :w
endfunction

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Visual find and replace over full file                        <Leader>fr', 'call VisualFindAndReplace()']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Visual find and replace over visual selection                 <Leader>fr', 'call VisualFindAndReplaceWithSelection()']]
