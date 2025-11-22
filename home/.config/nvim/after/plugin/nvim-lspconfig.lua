local cmp = require('cmp')
local feedkeys = require('cmp.utils.feedkeys')
local keymap = require('cmp.utils.keymap')
local lspkind = require('lspkind')
local select_options = { behavior = require('cmp.types').cmp.SelectBehavior.Select }

if not unpack then
  unpack = table.unpack
end

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

  -- Mappings
  local whichkey_register_lsp_capability = function(mappings)
    for keys, mapping_config in pairs(mappings) do
      local lsp_capability, action, description, local_options = unpack(mapping_config)
      local_options = local_options or {}
      lsp_capability = lsp_capability .. 'Provider'
      local icon = {}
      if not client.server_capabilities[lsp_capability] then
        icon = { icon = { icon = '', hl = 'WhichKeyIconRed' } }
        description = description .. ' (N/A)'
        action = function() print('ERROR - LSP "' .. lsp_capability .. '" capability is not available.') end
      end

      which_key.add({
        vim.tbl_extend(
          'force',
          { keys, action, desc = description, buffer = bufnr },
          local_options,
          icon
        )
      })
    end
  end

  -- To list capabilities:
  --    `:lua vim.lsp.get_active_clients()[1].server_capabilities`
  which_key.add({ { '<localleader>', group = 'Local Leader' }, })
  whichkey_register_lsp_capability(
    {
      ['<localleader>*'] = { 'references', builtin.lsp_references, 'Show references' },
      ['<localleader>#'] = { 'definition', builtin.lsp_definitions, 'Goto definition' },
      ['<localleader>^'] = { 'declaration', vim.lsp.buf.declaration, 'Goto declaration' },
      ['<localleader>0'] = { 'typeDefinition', builtin.lsp_type_definitions, 'Goto type definition' },

      ['<localleader>K'] = { 'hover', vim.lsp.buf.hover, 'Hover' },
      ['<C-k>'] = { 'signatureHelp', vim.lsp.buf.signature_help, 'Signature help', { mode = { 'n', 'i' } } },

      -- Changes code
      ['<localleader>r'] = { 'rename', vim.lsp.buf.rename, 'Rename' },
      ['<localleader>a'] = { 'codeAction', vim.lsp.buf.code_action, 'Code Action' },
    }
  )

  which_key.add({
    { '<localleader>g',  group = 'Goto',                                      buffer = bufnr },

    -- Common gotos
    { '<localleader>gi', builtin.lsp_implementations,                         desc = 'Goto implementation, word under the cursor', buffer = bufnr },

    -- Show symbols
    { '<localleader>gs', builtin.lsp_document_symbols,                        desc = 'Document symbols (buffer)',                  buffer = bufnr },
    { '<localleader>gS', builtin.lsp_workspace_symbols,                       desc = 'Document symbols (workspace)',               buffer = bufnr },
    { '<localleader>gy', builtin.lsp_dynamic_workspace_symbols,               desc = 'Dynamic symbols (workspace)',                buffer = bufnr },
    { '<localleader>gT', builtin.treesitter,                                  desc = 'Treesitter',                                 buffer = bufnr },

    -- Ins & outs
    { '<localleader>gI', builtin.lsp_incoming_calls,                          desc = 'Incoming calls, word under the cursor',      buffer = bufnr },
    { '<localleader>gO', builtin.lsp_outgoing_calls,                          desc = 'Outgoing calls, word under the cursor',      buffer = bufnr },

    -- Other
    { '<localleader>gg', function() builtin.diagnostics({ bufnr = 0 }) end,   desc = 'Diagnostics (buffer)',                       buffer = bufnr },
    { '<localleader>gG', function() builtin.diagnostics({ bufnr = nil }) end, desc = 'Diagnostics (workspace)',                    buffer = bufnr },
    { '<localleader>gl', builtin.loclist,                                     desc = 'Loclist',                                    buffer = bufnr },
    { '<localleader>gq', builtin.quickfix,                                    desc = 'Quickfix',                                   buffer = bufnr },
    { '<localleader>gw', '<cmd>TodoTelescope<cr>',                            desc = 'Todo (work) list',                           buffer = bufnr },
  })

  which_key.add({
    { '<localleader>w',  group = 'Workspace',                                                     buffer = bufnr },
    { '<localleader>wa', vim.lsp.buf.add_workspace_folder,                                        desc = 'add_workspace_folder',    buffer = bufnr },
    { '<localleader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = 'list_workspace_folders',  buffer = bufnr },
    { '<localleader>wr', vim.lsp.buf.remove_workspace_folder,                                     desc = 'remove_workspace_folder', buffer = bufnr },
  })

  -- Thank you:
  --   - https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
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

local cmp_formatting = function()
  -- This section is mostly from:
  --   - https://github.com/onsails/lspkind.nvim
  --   - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations=
  return {
    format = lspkind.cmp_format({
      -- mode = 'symbol',
      mode = 'symbol_text',
      menu = ({
        buffer = '[Buffer]',
        cmdline = '[CmdLine]',
        cmdline_history = '[History]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[NeovimLua]',
        path = '[Path]',
        vsnip = '[Vsnip]',
      })
    })
  }
end

-- From:
--   - https://github.com/hrsh7th/cmp-buffer?tab=readme-ov-file#visible-buffers
--   - https://github.com/hrsh7th/cmp-buffer?tab=readme-ov-file#indexing-and-how-to-optimize-it
local cmp_buffer_source = function()
  return {
    name = 'buffer',
    option = {
      get_bufnrs = function()
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local byte_size = vim.api.nvim_buf_get_offset(
            buf, vim.api.nvim_buf_line_count(buf)
          )
          if byte_size < 1048576 then -- 1 MB
            bufs[buf] = true
          end
        end
        return vim.tbl_keys(bufs)
      end
    },
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
    documentation = cmp.config.window.bordered(),
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
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      cmp_buffer_source(),
      { name = 'path' },
      { name = 'render-markdown' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }
  ),
  formatting = cmp_formatting(),
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    cmp_buffer_source(),
  })
})

for _, cmd_type in ipairs({ '/', '?' }) do
  cmp.setup.cmdline(cmd_type, {
    mapping = cmp.mapping.preset.cmdline(),
    -- mapping = cmp.mapping.preset.cmdline({
    --   ['<C-l>'] = cmp.mapping(complete_common_string, { 'c' }),
    --   ['<Tab>'] = cmp.mapping(cmd_select_func(cmp.select_next_item), { 'c' }),
    --   ['<S-Tab>'] = cmp.mapping(cmd_select_func(cmp.select_prev_item), { 'c' }),
    --   ['<CR>'] = cmp.mapping(confirm_func, { 'c' }),
    --   ['<M-CR>'] = cmp.mapping(confirm_insert_func, { 'c' }),
    -- }),
    sources = {
      -- { name = 'cmdline_history', option = { history_type = '/' }, },
      { name = 'buffer' },
    },
    formatting = cmp_formatting(),
  })
end

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  -- mapping = cmp.mapping.preset.cmdline({
  --   ['<C-l>'] = cmp.mapping(complete_common_string, { 'c' }),
  --   ['<Tab>'] = cmp.mapping(cmd_select_func(cmp.select_next_item), { 'c' }),
  --   ['<S-Tab>'] = cmp.mapping(cmd_select_func(cmp.select_prev_item), { 'c' }),
  --   ['<CR>'] = cmp.mapping(confirm_func, { 'c' }),
  --   ['<M-CR>'] = cmp.mapping(confirm_insert_func, { 'c' }),
  --   ['<Space>'] = cmp.mapping(confirm_with_tail('<Space>'), { 'c' }),
  -- }),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    -- { name = 'cmdline_history', option = { history_type = ':' }, },
    { name = 'cmdline' },
    { name = 'buffer' },
  }),
  matching = { disallow_symbol_nonprefix_matching = true },
  formatting = cmp_formatting(),
})


-- --------------------------------------------------------------------------
-- Colors
-- --------------------------------------------------------------------------
-- Colors for nvim-cmp completion menus. Thank you:
--   - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu=
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })


-- --------------------------------------------------------------------------
-- nvim-lsp-installer
-- --------------------------------------------------------------------------
-- This section is a mix of:
--   - https://github.com/neovim/nvim-lspconfig#suggested-configuration=
--   - https://github.com/hrsh7th/nvim-cmp/#recommended-configuration=
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

-- helm
lspconfig.helm_ls.setup({
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
  autostart = false, -- See `yaml.lua`
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
  settings = {
    yaml = {
      keyOrdering = false
    }
  }
})

-- vim
lspconfig.vimls.setup({
  capabilities = capabilities,
  flags = lsp_flags,
  on_attach = on_attach,
})
