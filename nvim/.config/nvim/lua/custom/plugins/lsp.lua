return {
  {
    'neovim/nvim-lspconfig',
    config = function ()
      vim.lsp.set_log_level("off")

      local capabilities = require('cmp_nvim_lsp').default_capabilities();
      local lsp_flags = {
        debounce_text_changes = 150,
      }
      local tel = require 'telescope.builtin'
      local on_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, bufopts)
        -- vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, bufopts)
        -- vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
        if client.server_capabilities.definitionProvider then
          vim.keymap.set('n', '<leader>d', tel.lsp_definitions, bufopts)
        end
        vim.keymap.set('n', '<leader>fr', tel.lsp_references, {})
        vim.keymap.set('n', '<leader>fc', tel.lsp_incoming_calls, {})
        vim.keymap.set('n', '<leader>fi', tel.lsp_implementations, {})
        vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>ls', "<cmd>:ClangdSwitchSourceHeader<cr>", bufopts)
        vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      require('lspconfig')['clangd'].setup{
        cmd = {"clangd", "--completion-style=detailed"},
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }
      require('lspconfig')['rust_analyzer'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }
      require('lspconfig')['pyright'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }
      require('lspconfig')['verible'].setup{
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
      }
    end
  }
}
