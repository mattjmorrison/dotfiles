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
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test JavaScript all tests (Qunit)                            9ja', 'echo "Use 9ja"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test JavaScript single asyncTest (Qunit)                     9js', 'echo "Use 9js"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test JavaScript single method (Qunit)                        9jm', 'echo "Use 9jm"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test JavaScript single test (Qunit)                          9jt', 'echo "Use 9jt"']]
