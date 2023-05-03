local cmp = require('cmp')
local compare = require('cmp.config.compare')
local feedkeys = require('cmp.utils.feedkeys')
local keymap = require('cmp.utils.keymap')
local lspkind = require('lspkind')
local select_options = { behavior = require('cmp.types').cmp.SelectBehavior.Select }

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

  local builtin = require('telescope.builtin')
  local which_key = require('which-key')

  -- Mappings.
  which_key.register({
    ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature help' },
    ['K'] = { vim.lsp.buf.hover, 'Hover' },
  }, {
    buffer = bufnr,
    noremap = true,
    silent = true,
  })

  which_key.register({
    a = { vim.lsp.buf.code_action, 'Code Action' },
    f = { function () vim.lsp.buf.format({async = true}) end, 'Re-format' },
    r = { vim.lsp.buf.rename, 'Rename' },
    g = {
      name = 'Goto',
      -- Common gotos
      d = { builtin.lsp_definitions, 'Goto definition, word under the cursor' },
      D = { vim.lsp.buf.declaration, 'Goto declaration' },
      t = { builtin.lsp_type_definitions, 'Goto type definition, word under the cursor' },
      i = { builtin.lsp_implementations, 'Goto implementation, word under the cursor' },
      r = { builtin.lsp_references, 'Show refs for word under the cursor' },

      -- Show symbols
      s = { builtin.lsp_document_symbols, 'Document symbols (buffer)' },
      S = { builtin.lsp_workspace_symbols, 'Document symbols (workspace)' },
      y = { builtin.lsp_dynamic_workspace_symbols, 'Dynamic symbols (workspace)' },
      T = { builtin.treesitter, 'Treesitter' },

      -- Ins & outs
      I = { builtin.lsp_incoming_calls, 'Incoming calls, word under the cursor' },
      O = { builtin.lsp_outgoing_calls, 'Outgoing calls, word under the cursor' },

      -- Other
      g = { function() builtin.diagnostics({ bufnr = 0 }) end, 'Diagnostics (buffer)' },
      G = { function() builtin.diagnostics({ bufnr = nil }) end, 'Diagnostics (workspace)' },
      l = { builtin.loclist, 'Loclist' },
      q = { builtin.quickfix, 'Quickfix' },
      w = { '<cmd>TodoTelescope<cr>', 'Todo (work) list' },
    },
    w = {
      name = 'Workspace',
      a = { vim.lsp.buf.add_workspace_folder, 'add_workspace_folder' },
      l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'list_workspace_folders' },
      r = { vim.lsp.buf.remove_workspace_folder, 'remove_workspace_folder' },
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

-- TODO - `cmp.mapping.complete_common_string()` should work.  Looks like an
-- upstream bug.
local complete_common_string = function(fallback)
  if cmp.visible() then
    cmp.complete_common_string()
  else
    fallback()
  end
end

local cmd_select_func = function(select_func)
  return function()
    if cmp.visible() then
      select_func(select_options)
    else
      feedkeys.call(keymap.t('<C-z>'), 'n')
    end
  end
end

local confirm_with_tail = function(key)
  return function(fallback)
    if cmp.visible() then
      cmp.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      })
      feedkeys.call(keymap.t(key), 'n')
    else
      fallback()
    end
  end
end

local confirm_func = cmp.mapping.confirm({
  behavior = cmp.ConfirmBehavior.Replace,
  select = false, -- Explicit selection one `false`
})

local confirm_insert_func = cmp.mapping.confirm({
  behavior = cmp.ConfirmBehavior.Insert,
  select = false, -- Explicit selection one `false`
})

local sort_config = function()
  -- This section is from:
  --   - https://www.reddit.com/r/neovim/comments/u3c3kw/how_do_you_sorting_cmp_completions_items/
  return {
    priority_weight = 1.0,
    comparators = {
      compare.length,  -- new
      compare.locality,
      compare.scopes, -- what?
      compare.recently_used,
      compare.exact,
      compare.score,
      compare.offset,
      compare.length,
      compare.sort_text,
      compare.order,
      -- compare.kind,
      -- compare.score_offset, -- not good at all
    }
  }
end

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
    ['<C-l>'] = complete_common_string,
    ['<Tab>'] = cmp.mapping.select_next_item(select_options),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(select_options),
    ['<CR>'] = cmp.mapping(confirm_func),
    ['<M-CR>'] = cmp.mapping(confirm_insert_func),
  }),
  sources = cmp.config.sources(
    {
      { name = 'path' },
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'buffer' },
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }
  ),
  formatting = {
    -- This section is mostly from:
    --   - https://github.com/onsails/lspkind.nvim
    --   - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations=
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[NeovimLua]',
        vsnip = '[Vsnip]',
      })
    }),
  },
  sorting = sort_config()
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
  mapping = cmp.mapping.preset.cmdline({
    ['<C-l>'] = cmp.mapping(complete_common_string, { 'c' }),
    ['<Tab>'] = cmp.mapping(cmd_select_func(cmp.select_next_item), { 'c' }),
    ['<S-Tab>'] = cmp.mapping(cmd_select_func(cmp.select_prev_item), { 'c' }),
    ['<CR>'] = cmp.mapping(confirm_func, { 'c' }),
    ['<M-CR>'] = cmp.mapping(confirm_insert_func, { 'c' }),
  }),
  sources = {
    { name = 'buffer' },
    {
      name = 'cmdline_history',
      option = { history_type = '/' },
      max_item_count = 7,
    },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      menu = ({
        buffer = '[Buffer]',
        cmdline_history = '[History]',
      })
    }),
  },
  sorting = sort_config(),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<C-l>'] = cmp.mapping(complete_common_string, { 'c' }),
    ['<Tab>'] = cmp.mapping(cmd_select_func(cmp.select_next_item), { 'c' }),
    ['<S-Tab>'] = cmp.mapping(cmd_select_func(cmp.select_prev_item), { 'c' }),
    ['<CR>'] = cmp.mapping(confirm_func, { 'c' }),
    ['<M-CR>'] = cmp.mapping(confirm_insert_func, { 'c' }),
    ['<Space>'] = cmp.mapping(confirm_with_tail('<Space>'), { 'c' }),
  }),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
    {
      name = 'cmdline_history',
      option = { history_type = ':' },
      max_item_count = 7,
    },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      menu = ({
        cmdline = '[CmdLine]',
        cmdline_history = '[History]',
        path = '[Path]',
      })
    }),
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      compare.length,
      compare.locality,
      compare.scopes, -- what?
      compare.exact,
      compare.score,
      compare.offset,
      compare.length,
      compare.sort_text,
      compare.order,
      compare.recently_used,
      -- compare.kind,
      -- compare.score_offset, -- not good at all
    }
  }
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


-- --------------------------------------------------------------------------
-- Colors
-- --------------------------------------------------------------------------
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
-- mason-lspconfig
-- --------------------------------------------------------------------------
require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true,
  -- ensure_installed = { 'tflint' },
})


-- --------------------------------------------------------------------------
-- nvim-lsp-installer
-- --------------------------------------------------------------------------
-- This section is a mix of:
--   - https://github.com/neovim/nvim-lspconfig#suggested-configuration=
--   - https://github.com/hrsh7th/nvim-cmp/#recommended-configuration=
local lspconfig = require('lspconfig')
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- ansible
lspconfig.ansiblels.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})

-- bashls
lspconfig.bashls.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})

-- docker
lspconfig.dockerls.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})

-- json
lspconfig.jsonls.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})

-- lua
lspconfig.lua_ls.setup({
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
})

-- pyright
lspconfig.pyright.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})

-- ruby (solargraph)
lspconfig.solargraph.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})

-- rust
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {}
  }
})

-- terraform
lspconfig.terraformls.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})

-- yaml
lspconfig.yamlls.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})

-- vim
lspconfig.vimls.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})
