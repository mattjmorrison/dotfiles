"===============================================================================
" Plugin source
"===============================================================================
"JarrodCTaylor/vim-python-test-runner"

"===============================================================================
" Plugin Configurations
"===============================================================================
" N/A

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>da :DjangoTestApp<CR>
nnoremap <Leader>df :DjangoTestFile<CR>
nnoremap <Leader>dc :DjangoTestClass<CR>
nnoremap <Leader>dm :DjangoTestMethod<CR>
nnoremap <Leader>nf :NosetestFile<CR>
nnoremap <Leader>nc :NosetestClass<CR>
nnoremap <Leader>nm :NosetestMethod<CR>
nnoremap <Leader>rr :RerunLastTests<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Django app                                              9da', 'echo "Use 9da"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Django class                                            9dc', 'echo "Use 9dc"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Django file                                             9df', 'echo "Use 9df"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Django method                                           9dm', 'echo "Use 9dm"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Python class with Nose                                  9nc', 'echo "Use 9nc"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Python file with Nose                                   9nf', 'echo "Use 9nf"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Python method with Nose                                 9nm', 'echo "Use 9nm"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Rerun last Python test                                       9rr', 'RerunLastTests']]
