-- --------------------------------------------------------------------------
-- LSP key mappings
-- --------------------------------------------------------------------------
-- Use an on_attach function to only map the following keys after the language
-- server attaches to the current buffer.
--   - https://github.com/neovim/nvim-lspconfig#suggested-configuration=
--   - See `:help vim.diagnostic.*` for documentation on any of the below functions
function on_attach(client, bufnr)
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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    on_attach(client, args.buf)
  end,
})
