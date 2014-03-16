set nocompatible              " be iMproved, required
set tabstop=2
set shiftwidth=2
set noexpandtab
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
" Too much already badly indented code
": autocmd BufWritePre *.t,*.p[lm] %s/\s\+$//e
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
