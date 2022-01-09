set encoding=utf-8
set nocompatible

set expandtab
ret tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set smarttab
set scrolloff=5
set nowrap

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
"hi statusline ctermbg=black ctermfg=yellow

command! W w "This lets you use capital w to save
command! Q q "Capital q now quits too

" Automatically close brackets
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap < <><Left>

" Change statusline color based off mode
" https://vim.fandom.com/wiki/Change_statusline_color_to_show_insert_or_normal_mode
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermfg=green
  elseif a:mode =="v" or a:mode == "V"
    hi statusline ctermfg=magenta
  else
    hi statusline ctermfg=red
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(visualmode())
au InsertLeave * hi statusline ctermfg=blue

" default the statusline to green when entering Vim
hi statusline ctermfg=blue
