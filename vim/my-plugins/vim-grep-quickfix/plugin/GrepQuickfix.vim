if exists("g:loaded_GrepQuickfix") || &cp
  finish
endif

let g:loaded_GrepQuickfix = 1

"mappings
let g:GQF_Grep          = !exists('g:GQF_Grep')? '<Leader>g' : g:GQF_Grep
let g:GQF_GrepV         = !exists('g:GQF_GrepV')? '<Leader>v' : g:GQF_GrepV
let g:GQF_Restore       = !exists('g:GQF_Restore')? '<Leader>r' : g:GQF_Restore
let g:GQF_Remove_Line   = !exists('g:GQF_Remove_Line')? '<Leader>d' : g:GQF_Remove_Line

"autocommands
function! <SID>FTautocmdBatch()
  command! GrepQuickfix       call GrepQuickfix#grep_QuickFix(0)  "invert flag =0
  command! GrepQuickfixV      call GrepQuickfix#grep_QuickFix(1)  "invert flag =1
  command! QuickfixRestore    call GrepQuickfix#restore_QuickFix()
  command! QuickfixRemoveLine call GrepQuickfix#remove_line_under_cursor()
  "mapping
  execute 'nnoremap <buffer><silent>' . g:GQF_Grep        . ' :GrepQuickfix<cr>'
  execute 'nnoremap <buffer><silent>' . g:GQF_GrepV       . ' :GrepQuickfixV<cr>'
  execute 'nnoremap <buffer><silent>' . g:GQF_Restore     . ' :QuickfixRestore<cr>'
  execute 'nnoremap <buffer><silent>' . g:GQF_Remove_Line . ' :QuickfixRemoveLine<cr>'
endfunction

augroup GQF
  au!
  autocmd QuickFixCmdPre * call GrepQuickfix#init_origQF()
  autocmd QuickFixCmdPost * call GrepQuickfix#fill_origQF()
  autocmd FileType qf call <SID>FTautocmdBatch()
augroup end
