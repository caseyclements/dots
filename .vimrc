" === Highlighting preferences ===
set term=xterm
syntax on
colorscheme evening
hi Search cterm=NONE ctermfg=grey ctermbg=blue
" show line numbers and cursor position
"set number
set ruler
"size of a hard tabstop
set tabstop=4
" size of an "indent"
set shiftwidth=4
" a combination of spaces and tabs are used to simulate tab stops at a width other than the (hard)tabstop
set softtabstop=4
" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab
" always uses spaces instead of tab characters
set expandtab
" Editor sometimes highlights tabs/spaces in fortran syntax. This  stops that
hi link fortranTab NONE
" Issue where delete was not working as backspace
set backspace=indent,eol,start
" Remap keys "
set pastetoggle=<F2>
nnoremap K $
" Search highlighting. Highlight all found results
set hlsearch

