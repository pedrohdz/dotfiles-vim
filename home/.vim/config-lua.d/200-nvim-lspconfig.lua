-- --------------------------------------------------------------------------
-- LSP key mappings
-- --------------------------------------------------------------------------
-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer.
--   - https://github.com/neovim/nvim-lspconfig#suggested-configuration=
--   - See `:help vim.diagnostic.*` for documentation on any of the below functions
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  require('which-key').register({
    ['<C-k>'] = { vim.lsp.buf.signature_help, 'signature_help' },
    ['<localleader>D'] = { vim.lsp.buf.type_definition, 'type_definition' },
    ['<localleader>ca'] = { vim.lsp.buf.code_action, 'code_action' },
    ['<localleader>f'] = { vim.lsp.buf.formatting, 'formatting' },
    ['<localleader>rn'] = { vim.lsp.buf.rename, 'rename' },
    ['<localleader>wa'] = { vim.lsp.buf.add_workspace_folder, 'add_workspace_folder' },
    ['<localleader>wl'] = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'list_workspace_folders' },
    ['<localleader>wr'] = { vim.lsp.buf.remove_workspace_folder, 'remove_workspace_folder' },
    ['K'] = { vim.lsp.buf.hover, 'Hover' },
    ['gD'] = { vim.lsp.buf.declaration, 'Goto declaration' },
    ['gd'] = { vim.lsp.buf.definition, 'Goto definition' },
    ['gi'] = { vim.lsp.buf.implementation, 'Goto implementation' },
    ['gr'] = { vim.lsp.buf.references, 'Goto references' },
  }, {
    buffer = bufnr,
    noremap = true,
    silent = true,
  })

  require('which-key').register({
    d = {
      name = 'Trouble',
      C = {'<cmd>TroubleClose<cr>', 'Close'},
      R = {'<cmd>TroubleRefresh<cr>', 'Refresh'},
      T = {'<cmd>TroubleToggle<cr>', 'Toggle'},
      c = {'<cmd>TodoTrouble<cr>', 'Todo comments'},
      d = {'<cmd>TroubleToggle document_diagnostics<cr>', 'LSP document diagnostics'},
      f = {'<cmd>TroubleToggle lsp_definitions<cr>', 'LSP definitions'},
      l = {'<cmd>TroubleToggle loclist<cr>', 'Loclist'},
      q = {'<cmd>TroubleToggle quickfix<cr>', 'LSP Quickfix'},
      r = {'<cmd>TroubleToggle lsp_references<cr>', 'LSP References'},
      t = {'<cmd>TroubleToggle lsp_type_definitions<cr>', 'LSP type definitions'},
      w = {'<cmd>TroubleToggle workspace_diagnostics<cr>', 'LSP workspace diagnostics'},
    },
  }, {
    buffer = bufnr,
    noremap = true,
    prefix = '<localleader>',
    silent = true,
  })

end


-- --------------------------------------------------------------------------
-- Setup nvim-cmp.
-- --------------------------------------------------------------------------
-- This section is mostly from:
--   - https://github.com/hrsh7th/nvim-cmp/#recommended-configuration=
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- elseif luasnip.expand_or_jumpable() then
      --   luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
      --   luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
    {
      name = 'cmdline_history',
      option = { history_type = '/' },
      max_item_count = 7,
    },
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    {
      name = 'cmdline_history',
      option = { history_type = ':' },
      max_item_count = 7,
    },
    { name = 'cmdline' },
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


-- --------------------------------------------------------------------------
-- Setup lspkind-nvim, adds vscode-like pictograms to neovim built-in lsp
-- --------------------------------------------------------------------------
-- This section is mostly from:
--   - https://github.com/onsails/lspkind.nvim
--   - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations=
local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[Latex]',
      })
    }),
  },
}

-- Colors for nvim-cmp completion menus. Thank you:
--   - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu=
--   - https://www.reddit.com/r/neovim/comments/r42njg/here_are_the_vs_code_theme_colors_for_the_new/hmelirh/
vim.cmd('set termguicolors')
vim.cmd('syntax on')
vim.cmd('highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE')
vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0')
vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')
vim.cmd('highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4')
vim.cmd('highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4')


-- --------------------------------------------------------------------------
-- nvim-lsp-installer
-- --------------------------------------------------------------------------
-- In order for nvim-lsp-installer to register the necessary hooks at the
-- right moment, make sure you call nvim-lsp-installer setup before you set
-- up any servers!
--   - https://github.com/neovim/nvim-lspconfig/wiki/Installing-language-servers
--   - https://github.com/williamboman/nvim-lsp-installer
require('nvim-lsp-installer').setup {
  automatic_installation = true
}


-- --------------------------------------------------------------------------
-- nvim-lsp-installer
-- --------------------------------------------------------------------------
-- This sectio is a mix of:
--   - https://github.com/neovim/nvim-lspconfig#suggested-configuration=
--   - https://github.com/hrsh7th/nvim-cmp/#recommended-configuration=
local lspconfig = require('lspconfig')
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- ansible
lspconfig.ansiblels.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}

-- bashls
lspconfig.bashls.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}

-- docker
lspconfig.dockerls.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}

-- json
lspconfig.jsonls.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}

-- lua
lspconfig.sumneko_lua.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- pyright
lspconfig.pyright.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}

-- ruby (solargraph)
lspconfig.solargraph.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}

-- rust
lspconfig.rust_analyzer.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {}
  }
}

-- terraform
lspconfig.terraformls.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

-- yaml
lspconfig.yamlls.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}

-- vim
lspconfig.vimls.setup{
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
}
