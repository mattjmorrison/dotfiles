" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

"===================================================================================
"  DESCRIPTION:  ”Life is frittered away by detail... simplify, simplify.” – Thoreau
"       AUTHOR:  Jarrod Taylor
" ____   ____.__                  .__               __
" \   \ /   /|__| _____           |__| ____ _____ _/  |_  ___________
"  \   Y   / |  |/     \   ______ |  |/    \\__  \\   __\/  _ \_  __ \
"   \     /  |  |  Y Y  \ /_____/ |  |   |  \/ __ \|  | (  <_> )  | \/
"    \___/   |__|__|_|  /         |__|___|  (____  /__|  \____/|__|
"                     \/                  \/     \/
"
"===================================================================================

" Buffer variables that control plugin loading {1
" To exclude plugins add the file name to the array below (i.e `let b:exclude = ["vim-hardtime.vim"]`)
let b:exclude = [""]
let b:pluginList = split(globpath('~/.vim/plugin-configs', '*.vim'), '\n')
let b:fileList = split(globpath('~/.vim/vanilla-configs', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/plugin-configs', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/custom-functions', '*.vim'), '\n')
"}1

" Function to process lists for sourceing and adding bundles {1
function! ProcessList(listToProcess, functionToCall)
    for fpath in a:listToProcess
        if index(b:exclude, split(fpath, "/")[-1]) >= 0
            continue
        else
            exe "call " . a:functionToCall . "('" . fpath . "')"
        endif
    endfor
endfunction

function! AddBundle(fpath)
    exe 'NeoBundle ' readfile(a:fpath, "", 4)[-1]
endfunction

function! SourceFile(fpath)
    exe 'source' a:fpath
endfunction
"}1

" Set leader keys {1
let mapleader="9"
let maplocalleader= '|'
" }1

" NeoBundle auto-installation and setup {1
" Install and configure NeoBundle {2
if !1 | finish | endif

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
    silent !curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" }2
" Bundles {2
call ProcessList(b:pluginList, "AddBundle")
" }2
" Auto install the plugins {2
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" }2
" }1

" Source Vim configurations {1
source ~/.vim/plugin-configs/unite.vim " Needs to be first so the others can add to the menu(s)
call ProcessList(b:fileList, "SourceFile")
" }1
