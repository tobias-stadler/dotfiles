return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "cuda", "rust", "python"},
          sync_install = false,
          auto_install = false,

          highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
          },
        })
    end
  },
  "nvim-treesitter/nvim-treesitter-context",
}
