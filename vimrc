execute pathogen#infect()
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set showmatch
set number
syntax enable
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
