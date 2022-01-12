set encoding=utf-8
set nocompatible
set noshowmode

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smartindent
set smarttab
set scrolloff=5
set nowrap

syntax enable
color delek

set number
set signcolumn=yes
set ruler
set cursorline
hi cursorline cterm=NONE ctermbg=235 ctermfg=NONE
set colorcolumn=80,88
hi ColorColumn guibg=darkgrey ctermbg=darkgrey

" disable colorcolumn on .txt and .md files
autocmd FileType text :set colorcolumn= 
autocmd FileType markdown :set colorcolumn=

" indentation guides
" set listchars=lead:\|
"set list

" autocomplete menu
set wildmenu
set wildmode=longest,list

" Set tab title to filename
let &titlestring=@%
set title

set backspace=indent,eol,start


" Statusline
set laststatus=2
set statusline=
set statusline+=\ %{StatuslineMode()} "Show vim mode
set statusline+=\ \|                "pipe divide
set statusline+=\ <<%f>>            "filename
set statusline+=\ %m                "modified flag 
set statusline+=\ %r                "readonly flag
set statusline+=%=                  "Switch to right side
set statusline+=%{b:gitbranch}      " Display current branch
set statusline+=\|                "pipe divide
set statusline+=\ %c                "column number 
set statusline+=\ \|                "pipe divide
set statusline+=\ %l/%L             "line number/total
set statusline+=\ (%p%%)            "Percentage

command! W w "This lets you use capital w to save
command! Q q "Capital q now quits too

" Automatically close brackets
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap < <><Left>

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    hi statusline ctermbg=blue
    return "NORMAL"
  elseif l:mode==?"v"
    hi statusline ctermbg=red
    return "VISUAL"
  elseif l:mode==#"i"
    hi statusline ctermbg=green
    return "INSERT"
  elseif l:mode==#"R"
    hi statusline ctermbg=blue
    return "REPLACE"
  elseif l:mode==?"s"
    hi statusline ctermbg=blue
    return "SELECT"
  elseif l:mode==#"t"
    hi statusline ctermbg=blue
    return "TERMINAL"
  elseif l:mode==#"c"
    hi statusline ctermbg=blue
    return "COMMAND"
  elseif l:mode==#"!"
    hi statusline ctermbg=blue
    return "SHELL"
  endif
endfunction

" default the statusline to green when entering Vim
hi statusline ctermbg=blue ctermfg=black

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END
