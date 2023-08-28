return {
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    config = function()
      require('Comment').setup()
      vim.keymap.set('n', "<leader>/",
        '<esc><cmd>lua require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>',
        { desc = "Toggle comment line" })
      vim.keymap.set('v', "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        { desc = "Toggle comment line for selection" })
    end,
    lazy = false,
  },
}
