setl laststatus=2

let s:currentmode={'n':  {'text': 'NORMAL',  'color': 60},
                 \ 'v':  {'text': 'VISUAL',  'color': 58},
                 \ 'V':  {'text': 'V-LINE',  'color': 58},
                 \ '': {'text': 'V-BLOCK', 'color': 58},
                 \ 'i':  {'text': 'INSERT',  'color': 29},
                 \ 'R':  {'text': 'REPLACE', 'color': 88}}

function! TextForCurrentMode()
    set lazyredraw
    if has_key(s:currentmode, mode())
        let modeMap = s:currentmode[mode()]
        execute 'hi! User1 ctermfg=255 ctermbg=' . modeMap['color'] . ' cterm=none'
        return modeMap['text']
    else
        return 'UNKNOWN'
    endif
    set nolazyredraw
endfunction

function! BuildStatusLine(showMode)
    hi User1 ctermfg=236 ctermbg=101 cterm=reverse
    hi User7 ctermfg=88  ctermbg=236 cterm=none
    hi User8 ctermfg=236 ctermbg=101 cterm=reverse
    setl statusline=
    if a:showMode
        setl statusline+=%1*\ %{TextForCurrentMode()}\ "
    endif
    setl statusline+=%<                              " Truncate contents after when line too long
    setl statusline+=%{&paste?'>\ PASTE':''}         " Alert when in paste mode
    setl statusline+=%8*\ %F                         " File path
    setl statusline+=%7*%m                           " File modified status
    setl statusline+=%8*                             " Set User8 coloring for rest of status line
    setl statusline+=%r%h%w                          " Flags
    setl statusline+=%=                              " Right align the rest of the status line
    setl statusline+=\ [TYPE=%Y]                     " File type
    setl statusline+=\ [POS=L%04l,R%04v]             " Cursor position in the file line, row
    setl statusline+=\ [LEN=%L]                      " Number of line in the file
    setl statusline+=%#warningmsg#                   " Highlights the syntastic errors in red
    setl statusline+=%{SyntasticStatuslineFlag()}    " Adds the line number and error count
endfunction

au WinLeave * call BuildStatusLine(0)
au WinEnter,VimEnter,BufWinEnter * call BuildStatusLine(1)
