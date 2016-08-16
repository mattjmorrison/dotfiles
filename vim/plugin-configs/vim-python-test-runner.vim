"===============================================================================
" Plugin source
"===============================================================================
"'JarrodCTaylor/vim-python-test-runner'

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
nnoremap <Leader>re :RerunLastTests<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Django app                                               <Leader>da', 'echo "Use <Leader>da"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Django class                                             <Leader>dc', 'echo "Use <Leader>dc"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Django file                                              <Leader>df', 'echo "Use <Leader>df"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Django method                                            <Leader>dm', 'echo "Use <Leader>dm"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Python class with Nose                                   <Leader>nc', 'echo "Use <Leader>nc"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Python file with Nose                                    <Leader>nf', 'echo "Use <Leader>nf"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Test Python method with Nose                                  <Leader>nm', 'echo "Use <Leader>nm"']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Rerun last Python test                                        <Leader>re', 'RerunLastTests']]
