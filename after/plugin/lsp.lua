local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({buffer = bufnr})
end)

local opts = {buffer = bufnr, remap = false}

vim.keymap.set("n", "gd", function() vim.lsp_zero.buf.definition() end, opts)
vim.keymap.set("n", "K", function() vim.lsp_zero.buf.hover() end, opts)
vim.keymap.set("n", "<leader>vws", function() vim.lsp_zero.buf.workspace_symbol() end, opts)
vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set("n", "<leader>vca", function() vim.lsp_zero.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp_zero.buf.references() end, opts)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp_zero.buf.rename() end, opts)
vim.keymap.set("i", "<C-h>", function() vim.lsp_zero.buf.signature_help() end, opts)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-n>'] = cmp.mapping.complete(),
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})

lsp_zero.setup()


require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = {'clangd', 'arduino_language_server', 'cssls', 'html', 'kotlin_language_server', 'lua_ls', 'matlab_ls', 'pyright', 'zls', 'rust_analyzer'},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	}
})
