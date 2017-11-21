set nocompatible              " required
set encoding=utf-8
set whichwrap+=h,l
nnoremap ; l
nnoremap l j
nnoremap j h
"call togglebg#map("<F5>")
set nu
syntax on
" Enable folding
set foldmethod=indent
set foldlevel=99
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamed
autocmd BufNewFile,BufRead *.asm set ft=masm
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
            \nmap <F2> :w<CR>
            \imap <F2> <ESC>:w<CR>i
            \map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
            \map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
            \map <F6> :Dox<CR>
            \map <F7> :make<CR>
            \map <S-F7> :make clean all<CR>
            \map <F12> <C-]>
"''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


let python_highlight_all=1
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix


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
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
