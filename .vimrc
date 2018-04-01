if has('persistent_undo')      "check if your vim version supports it
    set undofile                 "turn on the feature
    set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif
set nocompatible              " required
set encoding=utf-8
set whichwrap+=h,l
set nu
syntax on
set foldmethod=indent
set foldlevel=99
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set clipboard=unnamed
set showcmd
map <C-c> "+y
map <F2> <esc>ggVG<CR>
if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature  
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
  endif
    au BufNewFile,BufRead *.asm 
                \set ft=masm 

    "'''''''''''''''''''''''''''''''''''''''''''''''
    "c,c++  
    au BufNewFile,BufRead *.c
                \set enc=utf-8
                \set fenc=utf-8
                \set termencoding=utf-8
                \set nocompatible
                \set autoindent
                \set smartindent
                \set textwidth=120
                \set t_Co=256
                \syntax on
                \set showmatch
                \set comments=sl:/*,mb:\ *,elx:\ */
                \set tags+=~/.vim/tags/cpp
                \set tags+=~/.vim/tags/gl
                \set tags+=~/.vim/tags/sdl
                \set tags+=~/.vim/tags/qt4
                \let g:DoxygenToolkit_authorName="John Doe <john@doe.com>"
                augroup autoindent
                    au!
                    autocmd BufWritePre  :normal migg=G`i
                augroup End
    "''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



    " Enable folding with the spacebar
    nnoremap <space> za

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
    Plugin 'vim-scripts/indentpython.vim'
    Plugin 'tmhedberg/SimpylFold'
    Plugin 'scrooloose/syntastic'
    Plugin 'nvie/vim-flake8'
    Plugin 'jnurmine/Zenburn'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'scrooloose/nerdtree'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'kien/ctrlp.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
    Plugin 'ervandew/supertab'
    Plugin 'Valloric/YouCompleteMe'
    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
