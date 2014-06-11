set nocompatible      " We're running Vim, not Vi!
filetype off          " Enable filetype detection

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'

Plugin 'altercation/vim-colors-solarized'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()

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
map <C-l> :cp<CR>

set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set showmatch
set number                      " line numbering
set mouse=a                     " turn on the mouse
set backspace=indent,eol,start  " backspace all the things
set clipboard=unnamed           " use the system clipboard
syntax on

" Colors & Fonts
set background=light
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

" Automatically create parent directories
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
