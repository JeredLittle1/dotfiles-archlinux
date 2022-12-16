--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi

-- IMPORTS
require("vars")
require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- LSP
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local on_attach = function(client, bufnr)
	-- Format on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end

	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	kmap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	kmap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	kmap.set("n", "K", vim.lsp.buf.hover, bufopts)
	kmap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	kmap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	kmap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	kmap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	kmap.set("n", "<space>wl", function()
		rint(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	kmap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	kmap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	kmap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	kmap.set("n", "gr", vim.lsp.buf.references, bufopts)
	kmap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- Languages
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
})

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
})

lspconfig.remark_ls.setup({
	on_attach = on_attach,
})

-- Null-ls
null_ls.setup({
	sources = {
		-- Formatters
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,

		-- Diagnostics
		null_ls.builtins.diagnostics.eslint,

		-- Completion
		null_ls.builtins.completion.spell,

		-- Code Actions
		null_ls.builtins.code_actions.eslint,
	},
})