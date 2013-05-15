execute pathogen#infect()
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set showmatch
set number
syntax on
set background=dark
colorscheme solarized

function! StartUp()
  if 0 == argc()
    NERDTree
  end
endfunction

au VimEnter * call StartUp()

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

set nocompatible      " We're running Vim, not Vi!
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

autocmd FileType ruby compiler ruby

let mapleader = ","

" Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

let g:rspec_command = "!rspec --drb {spec}"

