if exists("g:autoloaded_GrepQuickfix") || &cp
  finish
endif
let g:autoloaded_GrepQuickfix = 1

let s:origQF        = !exists("s:origQF")? [] : s:origQF
"the message header
let s:msgHead = '[Grep-Quickfix] '

"read user's highlighting setting, and define highlighting groups
if !exists('g:GQF_hi_prompt')
  let g:GQF_hi_prompt='ctermbg=68 ctermfg=16 guibg=#5f87d7 guifg=black'
endif

if !exists('g:GQF_hi_info')
  let g:GQF_hi_info = 'ctermbg=113 ctermfg=16 guibg=#87d75f guifg=black'
endif

if !exists('g:GQF_hi_error')
  let g:GQF_hi_error = 'ctermbg=167 ctermfg=16 guibg=#d75f5f guifg=black'
endif

execute 'hi GQFPrompt ' . g:GQF_hi_prompt
execute 'hi GQFInfo '   . g:GQF_hi_info
execute 'hi GQFError '  . g:GQF_hi_error

"invoked by autocmd
function! GrepQuickfix#init_origQF()
  let s:origQF = []
endfunction

"invoked by autocmd
function! GrepQuickfix#fill_origQF()
  let s:origQF = getqflist()
endfunction

"do grep on quickfix entries
"if argument invert is 1, do invert match like grep -v
function! GrepQuickfix#grep_QuickFix(invert)
  "store original quickfix lists, so that later could be restored
  let s:origQF = len( s:origQF )>0? s:origQF : getqflist()
  let all = getqflist()
  if empty(all)
    call GrepQuickfix#print_err_msg('Quickfix window is empty. Nothing could be grepped. ')
    return
  endif
  let cp = deepcopy(all)
  call inputsave()
  echohl GQFPrompt
  let pat = input( s:msgHead . 'Pattern' . (a:invert?' (Invert-matching):':':'))
  echohl None
  call inputrestore()
  "clear the cmdline
  exec 'redraw'
  if empty(pat)
    call GrepQuickfix#print_err_msg("Empty pattern is not allowed")
    return
  endif
  try
    for d in cp
      if (!a:invert)
        if ( bufname(d['bufnr']) !~ pat && d['text'] !~ pat)
          call remove(cp, index(cp,d))
        endif
      else " here do invert matching
        if (bufname(d['bufnr']) =~ pat || d['text'] =~ pat)
          call remove(cp, index(cp,d))
        endif
      endif
    endfor
    if empty(cp)
      call GrepQuickfix#print_err_msg('Empty resultset, aborted.')
    else		"found entries
      call setqflist(cp)
      call GrepQuickfix#print_HLInfo(len(cp) . ' entries in Grep result.')
    endif
  catch /^Vim\%((\a\+)\)\=:E/
    call GrepQuickfix#print_err_msg('Pattern invalid')
  endtry
endfunction

function! GrepQuickfix#remove_line_under_cursor()
  let cp = deepcopy(getqflist())
  let theLineContent = split(getline('.'), '|\d\+ col \d\+|')[1].'$'
  let trimmedContent = substitute(theLineContent, '^\s*\(.\{-}\)\s*$', '\1', '')
  for d in cp
    if d['text'] =~ trimmedContent
      call remove(cp, index(cp,d))
    endif
  endfor
  call setqflist(cp)
endfunction

"restore quickfix items since last qf command
function! GrepQuickfix#restore_QuickFix()
  if len(s:origQF) > 0
    call setqflist(s:origQF)
    call GrepQuickfix#print_HLInfo('Quickfix entries restored.')
  else
    call GrepQuickfix#print_err_msg("Nothing can be restored")
  endif
endfunction

"print err message in err highlighting
function! GrepQuickfix#print_err_msg(errMsg)
  echohl GQFError
  echon s:msgHead . a:errMsg
  echohl None
endfunction

"print Highlighted info
function! GrepQuickfix#print_HLInfo(msg)
  echohl GQFInfo
  echon s:msgHead .  a:msg
  echohl None
endfunction
