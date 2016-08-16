"===============================================================================
" Plugin source
"===============================================================================
"'JarrodCTaylor/vim-ember-cli-test-runner'

"===============================================================================
" Plugin Configurations
"===============================================================================
" N/A

"===============================================================================
" Plugin Keymappings
"===============================================================================
nnoremap <Leader>et :RunSingleEmberTest<CR>
nnoremap <Leader>em :RunSingleEmberTestModule<CR>
nnoremap <Leader>ea :RunAllEmberTests<CR>
nnoremap <Leader>el :RerunLastEmberTests<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Run the single current Ember-CLI test                         <Leader>et', 'RunSingleEmberTest']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Run the single current Ember-CLI module                       <Leader>em', 'RunSingleEmberTestModule']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Run all the tests for the current Ember-CLI project           <Leader>ea', 'RunAllRmberTests']]
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Rerun the last Ember-CLI tests                                <Leader>el', 'RerunLastEmberTests']]
