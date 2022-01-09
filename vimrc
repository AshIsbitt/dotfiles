set encoding=utf-8

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set smarttab

syntax enable
color elflord

set number
set colorcolumn=80
set signcolumn=yes
hi ColorColumn guibg=grey ctermbg=grey
set ruler

" autocomplete menu
set wildmenu
set wildmode=longest,list

" Statusline
set laststatus=2
set statusline=<<%F>>       "filename
set statusline+=\ %m        "modified flag 
set statusline+=\ %r        "readonly flag
set statusline+=%=          "Switch to right side
set statusline+=\ %c        "column number 
set statusline+=\ \|        "pipe divide 
set statusline+=\ %l/%L     "line number/total
set statusline+=\ (%p%%)    "Percentage
hi statusline ctermbg=black ctermfg=yellow

command! W w "This lets you use capital w to save
command! Q q "Capital q now quits too

" Automatically close brackets
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap < <><Left>
