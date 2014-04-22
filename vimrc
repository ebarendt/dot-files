set nocompatible      " We're running Vim, not Vi!
filetype off          " Enable filetype detection

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rails'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'
Bundle 'rking/ag.vim'

filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

let mapleader = ","

" Rspec.vim mappings
map <Leader>r :Rake<CR>
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
let g:rspec_command = "!bundle exec rspec {spec}"

map <C-n> :cn<CR>
" map <C-p> :cp<CR>

set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set showmatch
set number
set mouse=a
set backspace=indent,eol,start
syntax on

" Colors & Fonts
set background=dark
colorscheme solarized
set guifont=Droid\ Sans\ Mono:h12

" Use Silver Searcher instead of grep
set grepprg=ag

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

" Let ctrl-p show hidden files (dotfiles)
let g:ctrlp_show_hidden = 1

" Strip trailing spaces
autocmd FileType rb,c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e
