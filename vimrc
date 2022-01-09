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
set statusline=
set statusline+=%2*                 
set statusline+=%{StatuslineMode()} "Show vim mode
set statusline=<<%F>>               "filename
set statusline+=\ %m                "modified flag 
set statusline+=\ %r                "readonly flag
set statusline+=%=                  "Switch to right side
set statusline+=%{b:gitbranch}      " Display current branch
set statusline+=\ \|                "pipe divide
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
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

" default the statusline to green when entering Vim
hi statusline ctermfg=blue

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
