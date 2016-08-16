"===============================================================================
" Plugin source
"===============================================================================
"'Shougo/unite.vim'

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:unite_enable_start_insert = 1
let g:unite_split_rule = 'botright'
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 15
let g:unite_prompt = '──➤  '
let g:unite_update_time = 200
let g:unite_data_directory = $HOME.'/.vim/tmp/unite'
let g:unite_source_buffer_time_format = '(%m-%d-%Y %H:%M:%S) '
let g:unite_source_file_mru_time_format = '(%m-%d-%Y %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%m-%d-%Y %H:%M:%S) '
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/git', 'ignore_globs', ['node_modules/**', 'bower_components/**'])

"-------------------------------------------------------------------------------
" Settings that take effect only in unite buffers
"-------------------------------------------------------------------------------
autocmd FileType unite call s:unite_buffer_settings()

function! s:unite_buffer_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  noremap <silent><buffer><expr> <C-d> unite#do_action('delete')
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

"===============================================================================
" Plugin Keymappings
"===============================================================================
" filter buffer for search term
nnoremap <Leader>sb :Unite line<CR>
nnoremap <Leader>sj :Unite jump<CR><Esc>
nnoremap <Leader>vu :PlugUpdate<CR>
nnoremap <Leader>ff :Unite file file_rec/git -start-insert -buffer-name=files -winheight=18<CR>
nnoremap <Leader>b :Unite buffer<CR>

"===============================================================================
" Setup Unite Menus Options
"===============================================================================
let g:unite_source_menu_menus = {}
nnoremap [menu] <Nop>
" menu prefix key (for all Unite menus)
nmap <LocalLeader> [menu]
nnoremap <silent>[menu]u :Unite -silent -winheight=20 menu<CR><Esc>

"===============================================================================
" Menu for Custom Key
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps = {'description': 'Custom mapped keyboard shortcuts                   |<SPACE>'}
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates = [
    \['➤ Buffer list                                                   <Leader>b', 'Unite buffer'],
    \['➤ Delete from buffer list in normal mode                        <C-d>', 'echo "Use <C-d> to delete a buffer"'],
    \['➤ Find files                                                    <Leader>ff', 'normal <Leader>ff'],
    \['➤ Search jumps                                                  <Leader>sj', 'Unite jump'],
    \['➤ Search lines in the current buffer                            <Leader>sb', 'Unite line'],
    \['➤ Update Vim plugins                                            <Leader>vu', 'normal <Leader>vu'],
    \['➤ Grep in Quickfix buffer                                       <Leader>g', 'echo "Use <Leader>g to grep within the Quickfix buffer"'],
    \['➤ Restore the Quickfix buffer                                   <Leader>r', 'echo "Use <Leader>r to restore the Quickfix buffer"'],
    \['➤ Reverse Grep in Quickfix buffer                               <Leader>v', 'echo "Use <Leader>v to reverse grep within the Quickfix buffer"'],
    \['➤ Reverse Grep Line Under Cursor in Quickfix buffer             <Leader>d', 'echo "Use <Leader>d to reverse grep the Line Under the Cursor in Quickfix buffer"'],
    \]
nnoremap <silent>[menu]<Space> :Unite -silent -winheight=17 -start-insert menu:CustomKeyMaps<CR>

"===============================================================================
" Plugin Keyboard Shortcuts
"===============================================================================
let g:unite_source_menu_menus.PluginKeyMaps = {'description': 'Keyboard shortcuts mapped by 3rd party plugins     |p'}
let g:unite_source_menu_menus.PluginKeyMaps.command_candidates = [
    \['➤ Replace in quickfix                                   :Qfreplace', 'echo "Use :Qfreplace"'],
    \]
nnoremap <silent>[menu]p :Unite -silent -winheight=17 -start-insert menu:PluginKeyMaps<CR>

"===============================================================================
" Vanilla Vim Keyboard Shortcuts
"===============================================================================
let g:unite_source_menu_menus.BuiltInKeyMaps = {'description': 'Lesser known/used builtin vim keybindings         |b'}
let g:unite_source_menu_menus.BuiltInKeyMaps.command_candidates = [
    \['➤ Show current char info                                        ga', 'normal ga'],
    \]
nnoremap <silent>[menu]b :Unite -silent -winheight=17 -start-insert menu:BuiltInKeyMaps<CR>

"===============================================================================
" HTTP Status Code Definitions
"===============================================================================
let g:unite_source_menu_menus.StatusCodeDefinitions = {'description': 'HTTP status code definitions               |sc'}
let g:unite_source_menu_menus.StatusCodeDefinitions.command_candidates = [
    \['➤ 100 Continue                                                   ', 'echo "Continue"'],
    \['➤ 101 Switching Protocols                                        ', 'echo "Switching Protocols"'],
    \['➤ 200 OK                                                         ', 'echo "OK"'],
    \['➤ 201 Created                                                    ', 'echo "Created"'],
    \['➤ 202 Accepted                                                   ', 'echo "Accepted"'],
    \['➤ 203 Non-Authoritative Information                              ', 'echo "Non-Authoritative Information"'],
    \['➤ 204 No Content                                                 ', 'echo "No Content"'],
    \['➤ 205 Reset Content                                              ', 'echo "Reset Content"'],
    \['➤ 206 Partial Content                                            ', 'echo "Partial Content"'],
    \['➤ 300 Multiple Choices                                           ', 'echo "Multiple Choices"'],
    \['➤ 301 Moved Permanently                                          ', 'echo "Moved Permanently"'],
    \['➤ 302 Found                                                      ', 'echo "Found"'],
    \['➤ 303 See Other                                                  ', 'echo "See Other"'],
    \['➤ 304 Not Modified                                               ', 'echo "Not Modified"'],
    \['➤ 305 Use Proxy                                                  ', 'echo "Use Proxy"'],
    \['➤ 307 Temporary Redirect                                         ', 'echo "Temporary Redirect"'],
    \['➤ 400 Bad Request                                                ', 'echo "Bad Request"'],
    \['➤ 401 Unauthorized                                               ', 'echo "Unauthorized"'],
    \['➤ 402 Payment Required                                           ', 'echo "Payment Required"'],
    \['➤ 403 Forbidden                                                  ', 'echo "Forbidden"'],
    \['➤ 404 Not Found                                                  ', 'echo "Not Found"'],
    \['➤ 405 Method Not Allowed                                         ', 'echo "Method Not Allowed"'],
    \['➤ 406 Not Acceptable                                             ', 'echo "Not Acceptable"'],
    \['➤ 407 Proxy Authentication Required                              ', 'echo "Proxy Authoritative Required"'],
    \['➤ 408 Request Timeout                                            ', 'echo "Request Timeout"'],
    \['➤ 409 Conflict                                                   ', 'echo "Conflict"'],
    \['➤ 410 Gone                                                       ', 'echo "Gone"'],
    \['➤ 411 Length Required                                            ', 'echo "Length Required"'],
    \['➤ 412 Precondition Failed                                        ', 'echo "Precondition Failed"'],
    \['➤ 413 Request Entity Too Large                                   ', 'echo "Request Entity Too Large"'],
    \['➤ 414 Request-URI Too Long                                       ', 'echo "Request-URI Too Long"'],
    \['➤ 415 Unsupported Media Type                                     ', 'echo "Unsupported Media Type"'],
    \['➤ 416 Requested Range Not Satisfiable                            ', 'echo "Requested Range Not Satisfiable"'],
    \['➤ 417 Expectation Failed                                         ', 'echo "Expectation Failed"'],
    \['➤ 422 Unprocessable Entity                                       ', 'echo "Unprocessable Entity"'],
    \['➤ 500 Internal Server Error                                      ', 'echo "Internal Server Error"'],
    \['➤ 501 Not Implemented                                            ', 'echo "Not Implemented"'],
    \['➤ 502 Bad Gateway                                                ', 'echo "Bad Gateway"'],
    \['➤ 503 Service Unavailable                                        ', 'echo "Service Unavailable"'],
    \['➤ 504 Gateway Timeout                                            ', 'echo "Gateway Timeout"'],
    \['➤ 505 HTTP Version Not Supported                                 ', 'echo "HTTP Version Not Supported"'],
    \]
nnoremap <silent>[menu]sc :Unite -silent -winheight=17 -start-insert menu:StatusCodeDefinitions<CR>
