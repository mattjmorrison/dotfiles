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
" }1

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
    exe 'call dein#add(' . readfile(a:fpath, "", 4)[-1]. ')'
endfunction

function! SourceFile(fpath)
    exe 'source' a:fpath
endfunction
"}1

" Dein auto install plug-ins {1
if &compatible
    set nocompatible
endif

set runtimepath^=~/.dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.dein'))
call dein#add('Shougo/dein.vim')
call dein#disable(g:exclude)
call ProcessList(b:pluginList, 'AddBundle')
call dein#local('~/dotfiles/vim/my-plugins')
call dein#end()
if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
" }1

" Source Vim configurations {1
call ProcessList(b:fileList, "SourceFile")
" }1


" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
