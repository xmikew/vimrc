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
Bundle 'yaifa.vim'
Bundle 'vim-misc'
Bundle 'easytags.vim'
Bundle 'SuperTab'
Bundle 'The-NERD-Tree'

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
"
"
filetype plugin indent on     " required

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

let mapleader=","

" edit vimrc
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" debug vim
nnoremap <leader>v0 :set verbose=0<cr>
nnoremap <leader>v5 :set verbose=5<cr>

" flip between tabs
nnoremap <C-h> :tabprevious<cr>
nnoremap <C-l> :tabnext<cr>
nnoremap <A-F1> 1gt
nnoremap <A-F2> 2gt
nnoremap <A-F3> 3gt
nnoremap <A-F4> 4gt
nnoremap <A-F5> 5gt
nnoremap <A-F6> 6gt
nnoremap <A-F7> 7gt
nnoremap <A-F8> 8gt
nnoremap <A-F9> 9gt
nnoremap <A-F0> 10gt

" clear search hl
nmap <silent> <leader>. :nohlsearch<CR>

" nerdtree open close
nnoremap <leader>nt :NERDTree<cr>

set pastetoggle=<F2>

:augroup prog_group
" : let g:easytags_auto_update = 1
: set tags=~/.vim/tags
: let g:easytags_file = '~/.vim/tags'
: let g:easytags_by_filetype = '~/.vim/filetype_tags'
: let g:easytags_dynamic_files = 1 

: set omnifunc=true
" from http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
: set completeopt=longest,menuone
: inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
: inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
: inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" set auto-complate menu colors to be less harsh
: highlight Pmenu    ctermbg=DarkGray  ctermfg=Black
: highlight PmenuSel ctermbg=LightGray ctermfg=darkmagenta

: autocmd!
: autocmd BufNewFile,BufRead *.t,*.p[lm] set filetype=perl
: autocmd BufNewFile,BufRead *.tt,*.tt2,*.tmpl set filetype=html

" PERL autocmds
: autocmd FileType perl set syntax=perl
" shortcut for normal mode to run on entire buffer then return to current line"
: autocmd Filetype perl nmap <leader>t :call DoPerlTidy()<CR>
" shortcut for visual mode to run on the the current visual selection"
: autocmd Filetype perl vmap <leader>t :PerlTidy<CR>
: autocmd Filetype perl map <silent> <leader>h :call Perldoc()<CR><CR>

" HTML autocmds
: autocmd FileType html set syntax=html
: autocmd Filetype html nmap <leader>t :call DoHTMLTidy()<CR>

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

"allow quicker resize of windows
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" run :Tidy on entire buffer and return cursor to (approximate) original position"
function! DoPerlTidy()
  let l:tidy_params = ['-l=0']
  :call add(l:tidy_params, '-i=' . &tabstop)

  if &expandtab
    call add(l:tidy_params, '-t -nola -et=' . &tabstop)
  endif

  let l:l = line(".")
  let l:c = col(".")
  exe "PerlTidy " . join(l:tidy_params)
  call cursor(l:l, l:c)
endfun

" integrate with PerlDoc
" originally stolen from: http://www.perlmonks.org/?node_id=441900
function! Perldoc(...)
  let l:args = ['-t']
  let l:keyword = 0
  " keyword povided example directly called
  if a:0 > 0
    let l:keyword = a:1
  else  
    normal yy
    let l:keyword = @
    if match(l:keyword, '^ *\(use\|require\) ') >= 0
      let l:keyword = substitute(l:keyword, '^ *\(use\|require\) *', "", "")
      let l:keyword = substitute(l:keyword, ";.*", "", "")
      let l:keyword = substitute(l:keyword, " .*", "", "")
    else
      let l:orig_keywords=&iskeyword
      let l:keywords = l:orig_keywords . ",$"
      exe 'setlocal iskeyword=' . l:keywords
      " grab function or var name
      normal yiw
      let l:keyword = @
      " grab esoterically named var
      normal y2l
      let l:var = @
      if match(l:var, '^\$[^A-Z]') >= 0
       let l:keyword = l:var 
      endif
      exe 'setlocal iskeyword=' . l:orig_keywords
    endif
  endif

  if match(l:keyword, '^\$') >= 0
    " probably a var
    call add(l:args, '-v')
  elseif match(l:keyword, '\([A-Z]\+\|::\)') < 0
    " probably a function
    call add(l:args, '-f')
  endif

  split perldoc
  resize 40
  setlocal nomod
  setlocal filetype=man
  setlocal buftype=nofile
  exe ':0r!perldoc ' . join(l:args) .  " '" . l:keyword . "'"
  normal 1G
  return
endfun

function! DoHTMLTidy()
  :HTMLTidy --indent yes --wrap 0 --tidy-mark no --force-output true -quiet --show-errors 0 --show-warnings 0
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
