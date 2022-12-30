--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi

-------- PLUGINS
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Packer

	-------- Appearance
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	use("neanias/everforest-nvim") -- Everforest theme

	use({
		"nvim-lualine/lualine.nvim", -- Status line
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-------- Neovim Tools
	use({
		"nvim-tree/nvim-tree.lua", -- Nvim Tree, NerdTree alternative
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	use({
		"nvim-treesitter/nvim-treesitter", -- Treesitter
		run = ":TSUpdate",
	})

	use({
		"nvim-telescope/telescope.nvim", -- Telescope
		tag = "0.1.0",
		requires = { "nvim-lua/plenary.nvim" },
	})

	------- Editing Tools
	use("windwp/nvim-autopairs") -- Auto closing brackets, paranthesis etc.
	use("lukas-reineke/indent-blankline.nvim") -- Line highlighting

	------- Git
	use({
		"lewis6991/gitsigns.nvim", -- Git signs
	})

	------- LSP
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	use({
		"ms-jpq/coq_nvim",
		branch = "coq",
		"ms-jpq/coq.artifacts",
		branch = "artifacts", -- 9000+ snippets
		"ms-jpq/coq.thirdparty",
		branch = "3p",
	})

	use("jose-elias-alvarez/null-ls.nvim") -- Formatter and diagnostics
end)
