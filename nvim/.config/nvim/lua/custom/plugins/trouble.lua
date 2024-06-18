return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      local trouble = require("trouble")
      trouble.setup { focus = true }
      vim.keymap.set('n', '<leader>tq', '<cmd>Trouble qflist open<cr>')
    end
  }
}
