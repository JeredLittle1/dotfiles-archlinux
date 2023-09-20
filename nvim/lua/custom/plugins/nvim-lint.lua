return {
  {
    "mfussenegger/nvim-lint",
    lazy = false,
    config = function()
      require("lint").linters_by_ft = {
        python = { "ruff" },
        terraform = { "tflint", "tfsec" },
        json = { "jsonlint" },
        yaml = { "yamllint" },

      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end
      })
    end
  }
}
