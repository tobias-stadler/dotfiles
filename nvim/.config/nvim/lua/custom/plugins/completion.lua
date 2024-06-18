return {
  {
    'hrsh7th/nvim-cmp', 
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
        build = "make install_jsregexp"
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function ()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      local ls = require('luasnip')
      ls.setup {
        enable_autosnippets = true,
        updateevents = "TextChanged,TextChangedI",
      }
      local opts = { noremap = true, silent = true }

      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, opts)

      vim.keymap.set({"i","s"}, "<C-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, opts)

      local cmp = require'cmp'
      cmp.register_source('tags', require('custom.tags'))

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-k>'] = cmp.mapping.confirm({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.filetype('systemverilog', {
        sources =
        {
          -- { name = 'nvim_lsp' },
          { name = 'tags' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    end
  }
}
