"===============================================================================
" ATTRIBUTION:   Code totally boosted from Tim Pope
" DESCRIPTION:   Automatically enter and exit paste mode without having to go
"                through the turn it on and off ritual
" EXAMPLE USAGE: press 'yp' and then paste without auto indentation beefing
"                things up then when you press <ESC> paste mode it
"                automatically toggled off.
"===============================================================================
function! s:setup_paste() abort
  let s:paste = &paste
  set paste
endfunction

augroup unimpaired_paste
  autocmd!
  autocmd InsertLeave *
        \ if exists('s:paste') |
        \   let &paste = s:paste |
        \   unlet s:paste |
        \ endif
augroup END

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <silent> <Plug>unimpairedPaste :call <SID>setup_paste()<CR>
nnoremap <silent> yp  :call <SID>setup_paste()<CR>a
nnoremap <silent> yP  :call <SID>setup_paste()<CR>i
nnoremap <silent> yo  :call <SID>setup_paste()<CR>o
nnoremap <silent> yO  :call <SID>setup_paste()<CR>O
nnoremap <silent> yA  :call <SID>setup_paste()<CR>A
nnoremap <silent> yI  :call <SID>setup_paste()<CR>I

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Enter paste mode [exit with <Esc>]                            yp', 'normal yp']]
