set tabstop=4
set softtabstop
set shiftwidth=4
set smartindent
set guicursor=
set nu
set nohlsearch
set colorcolumn=80
hi colorcolumn ctermbg=lightgrey guibg=lightgrey
set nowrap
set scrolloff=4
set signcolumn=yes

set completeopt=menu,menuone,noselect

" Plugins via vimPlug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugins')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()

lua require('gitsigns').setup()
