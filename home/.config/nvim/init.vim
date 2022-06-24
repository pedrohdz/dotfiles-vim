set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
runtime! config-lua.d/*.lua

set completeopt=menu,menuone,noselect
