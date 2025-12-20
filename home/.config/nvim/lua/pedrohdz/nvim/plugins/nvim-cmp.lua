-- --------------------------------------------------------------------------
-- Helper functions
-- --------------------------------------------------------------------------
-- This section is a mix of:
--   - https://github.com/hrsh7th/nvim-cmp/#recommended-configuration=

-- TODO - `cmp.mapping.complete_common_string()` should work.  Looks like an
-- upstream bug.
local complete_common_string = function(fallback)
  local cmp = require('cmp')
  if cmp.visible() then
    cmp.complete_common_string()
  else
    fallback()
  end
end

local confirm_func = function()
  local cmp = require('cmp')
  return cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = false, -- Explicit selection one `false`
  })
end

local confirm_insert_func = function()
  local cmp = require('cmp')
  return cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Insert,
    select = false, -- Explicit selection one `false`
  })
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

local cmp_formatting = function()
  -- This section is mostly from:
  --   - https://github.com/onsails/lspkind.nvim
  --   - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations=
  local lspkind = require('lspkind')
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


-- --------------------------------------------------------------------------
-- Setup functions
-- --------------------------------------------------------------------------
local setup_gitcommit_cmp = function()
  local cmp = require('cmp')
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      cmp_buffer_source(),
    })
  })
end

local setup_search_cmp = function()
  local cmp = require('cmp')
  for _, cmd_type in ipairs({ '/', '?' }) do
    cmp.setup.cmdline(cmd_type, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'cmdline_history', option = { history_type = '/' }, },
        { name = 'buffer' },
      },
      formatting = cmp_formatting(),
    })
  end
end

local setup_cmdline_cmp = function()
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  local cmp = require('cmp')
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline_history', option = { history_type = ':' }, },
      { name = 'cmdline' },
      { name = 'buffer' },
    }),
    matching = { disallow_symbol_nonprefix_matching = true },
    formatting = cmp_formatting(),
  })
end

-- Colors for nvim-cmp completion menus. Thank you:
--   - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu=
local setup_cmp_colors = function()
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
end

-- This section is a mix of:
--   - https://github.com/hrsh7th/nvim-cmp/#recommended-configuration=
local configure_lsp = function()
  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    -- flags = {
    --   -- This is the default in Nvim 0.7+
    --   debounce_text_changes = 150,
    -- },
  })
end

local setup = function()
  local cmp = require('cmp')
  local select_options = { behavior = require('cmp.types').cmp.SelectBehavior.Select }

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
      ['<CR>'] = confirm_func(),
      ['<M-CR>'] = confirm_insert_func(),
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

  setup_gitcommit_cmp()
  setup_cmdline_cmp()
  setup_search_cmp()
  setup_cmp_colors()
  configure_lsp()
end


-- --------------------------------------------------------------------------
-- Lazy config
-- --------------------------------------------------------------------------
return {
  'hrsh7th/nvim-cmp',
  version = '>0',

  dependencies = {
    'dmitmel/cmp-cmdline-history',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',

    -- For vsnip users.
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
  },

  config = setup,
}
