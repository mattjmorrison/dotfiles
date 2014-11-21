"===============================================================================
" Plugin source
"===============================================================================
"tpope/vim-fireplace"

"===============================================================================
" Plugin Configurations
"===============================================================================
" N/A

"===============================================================================
" Plugin Keymappings
"===============================================================================
augroup fireplace_custom
    autocmd FileType clojure nmap <buffer> <C-e> <Plug>FireplaceCountPrint
augroup END

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Eval the clojure expression under the cursor                  <C-e>', 'echo "Use <C-e> to eval clojure expression"']]
