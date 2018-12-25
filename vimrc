set nocompatible              " be iMproved, required
filetype off                  " required
set t_Co=256
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'yggdroot/indentline'
Plugin 'chr4/nginx.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'avakhov/vim-yaml'
call vundle#end()            " required
filetype plugin indent on    " required
colorscheme gruvbox
set background=dark
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set ai
set si
set nu
set colorcolumn=80
set noerrorbells visualbell t_vb=
filetype indent on
filetype plugin on
syntax enable
set term=screen-256color
set t_ut=
set modeline
set modelines=5
