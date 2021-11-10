set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set guicursor=
set nu
set nohlsearch
set colorcolumn=81
hi colorcolumn ctermbg=lightgrey guibg=lightgrey
set nowrap
set scrolloff=4
set signcolumn=yes

set completeopt=menu,menuone,noselect


" Plugins via vimPlug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugins')
Plug 'danilo-augusto/vim-afterglow'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'
call plug#end()

colorscheme afterglow

lua require('gitsigns').setup()

lua <<EOF
  -- Setup nvim-cmp.
	local cmp = require'cmp'
	local lspkind = require "lspkind"
	lspkind.init()

	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end,
		},

		mapping = {
			['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
			['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
			['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
			['<C-y>'] = cmp.config.disable, 
			['<C-e>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
		},

	-- Stolen from TJ
	-- https://github.com/tjdevries/config_manager/blob/c91305b584a866a52ae09e8d34fb6056081e3936/xdg_config/nvim/after/plugin/completion.lua#L144
		formatting = {
			format = lspkind.cmp_format {
				with_text = true,
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[LSP]",
					luasnip = "[snip]",
					},
				},
			},

		experimental = {
			native_menu = false,
			ghost_text = not is_wsl,
		},

		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			}, {
			{ name = 'buffer', keyword_length = 4},
		})
	})

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline('/', {
		sources = {
			{ name = 'buffer' }
			}
		})

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
		{ name = 'path' }
    }, {
		{ name = 'cmdline' }
		})
	})

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
	capabilities = capabilities
  }
EOF

