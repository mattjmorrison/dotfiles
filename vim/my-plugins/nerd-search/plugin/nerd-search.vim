" don't load multiple times
if exists("g:loaded_nerdtree_search")
    finish
endif

let g:loaded_nerdtree_search = 1

function! NERDTreeSearch()
    " get the current dir from NERDTree
    let cd = g:NERDTreeDirNode.GetSelected().path.str()

    " get the pattern
    let pattern = input("Search For: ")
    if pattern == ''
        echo 'Maybe another time...'
        return
    endif
    exec 'silent grep! "'.pattern.'" '.cd
    exec "redraw!"
    exec "redrawstatus!"
    exec "copen"
endfunction

" add the new menu item via NERD_Tree's API
call NERDTreeAddMenuItem({
    \ 'text': '(s)earch directory',
    \ 'shortcut': 's',
    \ 'callback': 'NERDTreeSearch' })
