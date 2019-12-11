"===============================================================================
" Plugin source
"===============================================================================
"'mattn/emmet-vim'

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key=','
" Enable just in html-like files
autocmd FileType html,htmldjango,handlebars,html.handlebars EmmetInstall

"===============================================================================
" Plugin Keymappings
"===============================================================================
" N/A

"===============================================================================
" Unite Keymap Menu Item(s)
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates += [['➤ Trigger emmet expansion                                       ,', 'echo "use `,` to expand html tags"']]
