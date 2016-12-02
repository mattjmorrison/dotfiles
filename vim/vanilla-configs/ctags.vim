"===============================================================================
" Vim will look for a ctags file in the current directory and continue
" up the file path until it finds one
"===============================================================================
set tags=./.ctags,.ctags;

"===============================================================================
" If a ctags file exists updated it if not create one
"===============================================================================
function! RenewTagsFile()
    exe 'silent !rm -rf .ctags'
    exe 'silent !ctags -a -Rf .ctags --languages=python --python-kinds=-iv --exclude=build --exclude=dist ' . system('python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"')''
    exe 'silent !ctags -a -Rf .ctags --extra=+f --exclude=.git --languages=python --python-kinds=-iv --exclude=build --exclude=dist 2>/dev/null'
    exe 'redraw!'
endfunction

"===============================================================================
" Function Keymappings
"===============================================================================
nnoremap <Leader>rt :call RenewTagsFile()<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Refresh or create ctags file                                  <Leader>rt', 'call RenewTagsFile()']]
