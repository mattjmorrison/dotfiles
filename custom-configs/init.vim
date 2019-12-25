set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
call plug#end()

""""""""""""""""""""""""""""nerdcommenter settings"""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use one space after # comment character in python,
" see http://tinyurl.com/y4hm29o3
let g:NERDAltDelims_python = 1

" Align line-wise comment delimiters flush left instead
" of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Show current line where the cursor is
set cursorline
" Set a ruler at column 80, see https://goo.gl/vEkF5i
set colorcolumn=80
set number relativenumber

nnoremap <silent> <leader>f :FZF<cr>
