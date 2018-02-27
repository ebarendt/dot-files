packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('altercation/vim-colors-solarized')
call minpac#add('kchmck/vim-coffee-script')
call minpac#add('kien/ctrlp.vim')
call minpac#add('scrooloose/nerdtree')
call minpac#add('tpope/vim-bundler')
call minpac#add('tpope/vim-rails')
call minpac#add('pangloss/vim-javascript')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('rking/ag.vim')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-endwise')
call minpac#add('bling/vim-airline')
call minpac#add('elixir-lang/vim-elixir')

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

let mapleader = ","

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

" http://vim.wikia.com/wiki/Any_word_completion
set completeopt=longest         " turn off the autocomplete menu
syntax on

" Colors & Fonts
" set background=light
" colorscheme solarized
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12

" Use Silver Searcher instead of grep
set grepprg=ag

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

" Let ctrl-p show hidden files (dotfiles)
let g:ctrlp_show_hidden = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Strip trailing spaces
autocmd FileType rb,c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

" Enable crontab -e on OSX
autocmd filetype crontab setlocal nobackup nowritebackup

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

" Tell vim about arduino
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp

" airline config
set laststatus=2
" let g:airline_powerline_fonts = 1
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_symbols.space = "\ua0"

" Mark tabs and trailing whitepace
set list listchars=tab:\|_,trail:·
