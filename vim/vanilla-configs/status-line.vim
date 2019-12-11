setl laststatus=2

let s:currentmode={'n':  {'text': 'NORMAL',  'termColor': 60, 'guiColor': '#076678'},
                 \ 'v':  {'text': 'VISUAL',  'termColor': 58, 'guiColor': '#D65D0E'},
                 \ 'V':  {'text': 'V-LINE',  'termColor': 58, 'guiColor': '#D65D0E'},
                 \ '': {'text': 'V-BLOCK', 'termColor': 58, 'guiColor': '#D65D0E'},
                 \ 'i':  {'text': 'INSERT',  'termColor': 29, 'guiColor': '#8EC07C'},
                 \ 'R':  {'text': 'REPLACE', 'termColor': 88, 'guiColor': '#CC241D'}}

function! TextForCurrentMode()
    set lazyredraw
    if has_key(s:currentmode, mode())
        let modeMap = s:currentmode[mode()]
        execute 'hi! User1 ctermfg=255 ctermbg=' . modeMap['termColor'] . 'guifg=#EEEEEE guibg=' . modeMap['guiColor'] . ' cterm=none'
        return modeMap['text']
    else
        return 'UNKNOWN'
    endif
    set nolazyredraw
endfunction

function! BuildStatusLine(showMode)
    hi User1 ctermfg=236 ctermbg=101 guifg=#303030 guibg=#87875F cterm=reverse
    hi User7 ctermfg=88  ctermbg=236 guifg=#870000 guibg=#303030 cterm=none
    hi User8 ctermfg=236 ctermbg=101 guifg=#303030 guibg=#87875F cterm=reverse
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
endfunction

au WinLeave * call BuildStatusLine(0)
au WinEnter,VimEnter,BufWinEnter * call BuildStatusLine(1)
