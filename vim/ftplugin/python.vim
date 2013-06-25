"===================================================================================
"         FILE:  python.vim
"  DESCRIPTION:  Settings that load only for files with the .py extension
"       AUTHOR:  Jarrod Taylor
"      CREATED:  06.19.2011
"       UPDTED:  07.21.2012
"===================================================================================
"
" Settings for proper indentation
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab

" Execute file being edited with <F2> using Python3
map <buffer> <F3> :!/usr/bin/python3 % 

" Execute file being edited with <F2> using Python2.7
map <buffer> <F2> :!/usr/bin/python2.7 % 

" Color the 80th column as a reminder of proper line length
set colorcolumn=120
highlight colorcolumn ctermbg=7
highlight ColorColumn guibg=thistle4
" highlight ColorColumn ctermbg=green guibg=orange

" Python mode plugin turns numbers on by default
set nonumber
