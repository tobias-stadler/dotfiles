local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<Esc>', vim.cmd.noh, opts)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts)

vim.keymap.set('n', '<leader>s', vim.cmd.write, {})
vim.keymap.set('n', '<leader>d', '<C-]>', {})
