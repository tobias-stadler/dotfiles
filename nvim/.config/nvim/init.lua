vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.mouse = "nv"

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

vim.cmd[[colorscheme tokyonight]]

require'treesitter-context'.setup{
  enable = true,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
}

vim.lsp.set_log_level("off")

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>l[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>l]', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.keymap.set('n', '<leader>s', vim.cmd.write, {})
vim.keymap.set('n', '<leader>d', '<C-]>', {})

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, bufopts)
    if client.server_capabilities.definitionProvider then
        vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
    end
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, bufopts)
   -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
        -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>ls', "<cmd>:ClangdSwitchSourceHeader<cr>", bufopts)
    -- vim.keymap.set('n', '<leader>', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

vim.opt.completeopt={"menu","menuone","noselect"}

local ls = require('luasnip')
ls.config.set_config {
    history = true,
    enable_autosnippets = true,
    updateevents = "TextChanged,TextChangedI",
}

local cmp = require'cmp'
cmp.register_source('tags', require('tags'))

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
        --{ name = 'nvim_lsp' },
        { name = 'tags' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    }
})

vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({"i","s"}, "<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, {silent = true})

local tel = require 'telescope.builtin'

vim.keymap.set('n', '<leader>ff', tel.find_files, {})
vim.keymap.set('n', '<leader>fp', tel.git_files, {})
vim.keymap.set('n', '<leader>fg', tel.live_grep, {})
vim.keymap.set('n', '<leader>fb', tel.buffers, {})
vim.keymap.set('n', '<leader>fr', tel.lsp_references, {})
vim.keymap.set('n', '<leader>fi', tel.lsp_incoming_calls, {})

require("luasnip.loaders.from_vscode").lazy_load()

local capabilities = require('cmp_nvim_lsp').default_capabilities();

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
