"===============================================================================
" Plugin source
"===============================================================================
"JarrodCTaylor/vim-sql-suggest"

"===============================================================================
" Plugin Configurations
"===============================================================================
" let g:suggest_db = "mysql -u root test"
let g:suggest_db = "psql -U Jrock libexample"

"===============================================================================
" Plugin Keymappings
"===============================================================================
inoremap <Leader>sc <C-R>=SQLComplete("column")<CR>
inoremap <Leader>st <C-R>=SQLComplete("table")<CR>

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += ['➤ Suggest SQL column name in insert mode                       9sc', 'echo "Use 9sc in insert mode to suggest a sql column name"']
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += ['➤ Suggest SQL table name in insert mode                        9st', 'echo "Use 9st in insert mode to suggest a sql table name"']
