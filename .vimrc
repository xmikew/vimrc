set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'

" The following are examples of different formats supported.
" Keep bundle commands between here and filetype plugin indent on.
" scripts on GitHub repos
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'tpope/vim-rails.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" scripts not on GitHub
" Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Bundle 'file:///home/gmarik/path/to/plugin'
" ...

filetype plugin indent on     " required
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.


" My config
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set hlsearch
set showmatch
set matchtime=5
set backspace=indent,eol,start
set novisualbell
set ruler
set showcmd
set noerrorbells
set laststatus=2
set nonumber
set wildmode=longest,list
set foldenable
set foldmethod=marker
set foldlevel=100
syntax on

" edit vimrc
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" debug vim
nnoremap <leader>v0 :set verbose=0<cr>
nnoremap <leader>v5 :set verbose=5<cr>
nnoremap <leader>v9 :set verbose=9<cr>

" flip between tabs
nnoremap <leader>[ :tabprev<cr>
nnoremap <leader>] :tabnext<cr>

" perl autocmds and maps
:augroup perl_file
: autocmd!
: autocmd BufNewFile,BufRead *.t,*.p[lm] set filetype=perl
: autocmd BufNewFile,BufRead *.tt2?,*.tmpl set filetype=html
: autocmd FileType perl set syntax=perl
: autocmd FileType html set syntax=html
: autocmd BufWritePre *.t,*.p[lm] %s/\s\+$//e
:augroup ENm

" Stole from sartak blog => Amablue's function
" Call with <leader><space> for non-perl files..
function! <sid>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

nnoremap <silent> <leader><space> :call <sid>StripTrailingWhitespace()<cr>
