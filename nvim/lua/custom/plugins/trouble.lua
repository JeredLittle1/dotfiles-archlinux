return {
  {
    "folke/trouble.nvim",
    opts = {
    },
    config = function()
      vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>",
        { desc = "[T]rouble Toggle", noremap = true, silent = true })
    end,
    lazy = false
  },
}
