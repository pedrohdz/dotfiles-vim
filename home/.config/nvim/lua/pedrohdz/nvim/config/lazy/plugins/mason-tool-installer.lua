-- More information:
--   https://github.com/WhoIsSethDaniel

-- ----------------------------------------------------------------------------
-- Autocmd
-- ----------------------------------------------------------------------------
local group_id = vim.api.nvim_create_augroup(
  'pedrohdz.mason-tool-installer',
  { clear = true }
)

vim.api.nvim_create_autocmd(
  { 'User' },
  {
    group = group_id,
    pattern = 'MasonToolsStartingInstall',
    callback = function()
      vim.schedule(function()
        print 'Starting mason-tool-installer…'
      end)
    end,
  })

vim.api.nvim_create_autocmd(
  { 'User' },
  {
    group = group_id,
    pattern = 'MasonToolsUpdateCompleted',
    callback = function(e)
      vim.schedule(function()
        if #e.data > 0 then
          print('Installed by mason-tool-installer: ' .. vim.inspect(e.data))
        end
      end)
    end,
  })

-- ----------------------------------------------------------------------------
-- Configuration
-- ----------------------------------------------------------------------------
local function options()
  return {
    ensure_installed = {
      'prettierd'
    },
    auto_update = false,
    run_on_start = true,
    -- start_delay = 3000, -- 3 second delay
    integrations = {
      ['mason-lspconfig'] = false,
      ['mason-null-ls'] = false,
      ['mason-nvim-dap'] = false,
    },
  }
end

-- ----------------------------------------------------------------------------
-- Lazy
-- ----------------------------------------------------------------------------
return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = options()
}
