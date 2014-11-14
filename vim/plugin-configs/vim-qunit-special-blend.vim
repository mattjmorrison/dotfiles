"===============================================================================
" Plugin source
"===============================================================================
"JarrodCTaylor/vim-qunit-special-blend"

"===============================================================================
" Plugin Configurations
"===============================================================================
" N/A

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>ja :RunAllQunitTests<CR>
nnoremap <Leader>jt :RunSingleQunitTest<CR>
nnoremap <Leader>js :RunSingleAsyncQunitTest<CR>
nnoremap <Leader>jm :RunSingleQunitModule<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test JavaScript all tests (Qunit)                             <Leader>ja', 'echo "Use <Leader>ja"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test JavaScript single asyncTest (Qunit)                      <Leader>js', 'echo "Use <Leader>js"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test JavaScript single method (Qunit)                         <Leader>jm', 'echo "Use <Leader>jm"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test JavaScript single test (Qunit)                           <Leader>jt', 'echo "Use <Leader>jt"']]
