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
Bundle 'vim-scripts/IndentConsistencyCop'
Bundle 'yaifa'

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

" flip between tabs
nnoremap <C-h> :tabprevious<cr>
nnoremap <C-l> :tabnext<cr>

:augroup prog_group
: autocmd!
: autocmd BufNewFile,BufRead *.t,*.p[lm] set filetype=perl
: autocmd BufNewFile,BufRead *.tt,*.tt2,*.tmpl set filetype=html

" PERL autocmds
: autocmd FileType perl set syntax=perl
" shortcut for normal mode to run on entire buffer then return to current line"
: autocmd Filetype perl nmap <F2> :call DoPerlTidy()<CR>
" shortcut for visual mode to run on the the current visual selection"
: autocmd Filetype perl vmap <F2> :PerlTidy<CR>
map ,h :call doPerldoc()<CR>:set nomod<CR>:set filetype=man<CR>:echo "perldoc"<CR>

" HTML autocmds
: autocmd FileType html set syntax=html
: autocmd Filetype html nmap <F2> :call DoHTMLTidy()<CR>

" JS autocmds
" need tidy program
" Disable due to issue when modifying FOSS
": autocmd BufWritePre *.t,*.p[lm] %s/\s\+$//e

"
:augroup END

" Stolen from: http://stackoverflow.com/questions/2345519/how-can-i-script-vim-to-run-perltidy-on-a-buffer
" define :Tidy command to run perltidy on visual selection || entire buffer"
command! -range=% -nargs=* PerlTidy <line1>,<line2>!perltidy <args>
command! -range=% -nargs=* HTMLTidy <line1>,<line2>!tidy <args>

" run :Tidy on entire buffer and return cursor to (approximate) original position"
function! DoPerlTidy()
  let tidy_params = ['-l=0']
  :call add(tidy_params, '-i=' . &tabstop)

  if &expandtab
    :call add(tidy_params, '-t -nola -et=' . &tabstop)
  endif

  let l = line(".")
  let c = col(".")
  exe "PerlTidy " . join(tidy_params)
  call cursor(l, c)
endfun

" integrate with PerlDoc
" Stolen from: http://www.perlmonks.org/?node_id=441900
function! doPerldoc()
  normal yy
  let l:this = @
  if match(l:this, '^ *\(use\|require\) ') >= 0
    exe ':new'
    exe ':resize'
    let l:this = substitute(l:this, '^ *\(use\|require\) *', "", "")
    let l:this = substitute(l:this, ";.*", "", "")
    let l:this = substitute(l:this, " .*", "", "")
    exe ':0r!perldoc -t ' . l:this
    exe ':0'
    return
  endif
  normal yiw
  exe ':new'
  exe ':resize'
  exe ':0r!perldoc -t -f ' . @
  exe ':0'
endfun

function! DoHTMLTidy()
  let l = line(".")
  let c = col(".")
  :HTMLTidy --indent yes --wrap 0 --tidy-mark no --force-output true -quiet --show-errors 0 --show-warnings 0
  call cursor(l,c)
endfun

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

" indent cop
nnoremap <silent> <leader>ic :IndentConsistencyCop<cr>

" set indent
nnoremap <silent> <leader>si :YAIFAMagic<cr>
