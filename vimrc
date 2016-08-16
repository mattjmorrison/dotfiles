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

" Source custom-init to allow excluding plugins {1
let b:customInit=expand('~/dotfiles/custom-configs/**/custom-init.vim')
if filereadable(b:customInit)
    exe 'source' b:customInit
endif

if !exists("g:exclude")
    let g:exclude = [""]
endif
" }1

" Buffer variables that control plugin loading {1
let b:pluginList = split(globpath('~/.vim/order-dependent-unite-config', '*.vim'), '\n')
let b:pluginList += split(globpath('~/.vim/plugin-configs', '*.vim'), '\n')
let b:pluginList += split(globpath('~/dotfiles/custom-configs/**', '*-plugin.vim'), '\n')
let b:fileList = split(globpath('~/.vim/order-dependent-unite-config', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/vanilla-configs', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/plugin-configs', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/functions', '*.vim'), '\n')
let b:fileList += split(globpath('~/dotfiles/custom-configs/**', '*.vim'), '\n')
"}1

" Set leader keys {1
let mapleader=" "
let maplocalleader= '|'
"}1

" Function to process lists for sourceing and adding bundles {1
function! ProcessList(listToProcess, functionToCall)
    for fpath in a:listToProcess
        if index(g:exclude, split(fpath, "/")[-1]) >= 0
            continue
        else
            call {a:functionToCall}(fpath)
        endif
    endfor
endfunction

function! AddBundle(fpath)
    execute "Plug " . readfile(a:fpath, "", 4)[-1][1:]
endfunction

function! SourceFile(fpath)
    exe 'source' a:fpath
endfunction
"}1

" Manage plug-ins {1
if &compatible
    set nocompatible
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
call ProcessList(b:pluginList, 'AddBundle')
Plug '~/dotfiles/vim/my-plugins/vim-grep-quickfix'
Plug '~/dotfiles/vim/my-plugins/vim-wiki-links'
call plug#end()

filetype plugin indent on
" }1

" Source Vim configurations {1
call ProcessList(b:fileList, "SourceFile")
" }1
