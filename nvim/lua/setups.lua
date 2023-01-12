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
require("lsp-config") -- local LSP config file

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

-- SETUPS

-- NvimTree
require("nvim-tree").setup()

-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"clangd",
		"cssls",
		"dotls",
		"eslint",
		"html",
		"jsonls",
		"ltex",
		"marksman",
		"rust_analyzer",
		"sqlls",
		"sumneko_lua",
		"tsserver",
		"yamlls",
	},
	automatic_installation = true,
})

-- Alpha start screen / dashboard
require("alpha").setup(require("alpha.themes.startify").config)

-- Everforest theme
require("everforest").setup({
	background = "medium",
	transparent_background_level = 0,
})

-- Lualine status bar
require("lualine").setup({
	options = {
		component_separators = " ",
		section_separators = { left = "", right = "" },
	},
})

-- Nvim Autopairs
require("nvim-autopairs").setup()

-- Git signs
require("gitsigns").setup()

-- Line highlighting
require("indent_blankline").setup({
	char = "┊",
})

-- Hex color highlighting
require("colorizer").setup()

-- Languages
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
})

lspconfig.clangd.setup({
	on_attach = on_attach,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
})

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

lspconfig.marksman.setup({
	on_attach = on_attach,
})

lspconfig.ltex.setup({
	on_attach = on_attach,
	filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "text" },
})

lspconfig.bashls.setup({
	on_attach = on_attach,
})

lspconfig.html.setup({
	on_attach = on_attach,
})

-- Null-ls
null_ls.setup({
	sources = {
		-- Formatters
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.shfmt,

		-- Diagnostics
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.codespell,

		-- Code Actions
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.code_actions.shellcheck,
	},
})
