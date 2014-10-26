"===============================================================================
" DESCRIPTION:   Toggle the quickfix window open and closed
" EXAMPLE USAGE: Press <Leader>q to toggle the quickfix window
"===============================================================================
let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>q :call QuickfixToggle()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += ['➤ Toggle quickfix                                               9q', 'call QuickfixToggle()']
