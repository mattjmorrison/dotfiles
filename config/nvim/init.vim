set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ycm-core/YouCompleteMe'
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

let g:EditorConfig_core_mode = 'external_command'

" Show current line where the cursor is
set cursorline
" Set a ruler at column 80, see https://goo.gl/vEkF5i
set colorcolumn=80
set number relativenumber

""""""""""""""""""""""""""""Personal remappings"""""""""""""""""""""""""
:let mapleader = "-"
:inoremap <c-u> <esc>viwU<esc>i
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
:inoremap jk <esc>
:inoremap <esc> <nop>
:inoremap <leader>* print('*' * 30)
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p
set clipboard=unnamed
nnoremap <silent> <leader>f :FZF<cr>

"""""""""""""""""""""""""""""Nerdtree"""""""""""""""""""""""""""""""""""
" autocmd vimenter * NERDTree
:nnoremap <C-n> :NERDTreeToggle<CR>

