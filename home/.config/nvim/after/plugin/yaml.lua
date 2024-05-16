-- ----------------------------------------------------------------------------
-- YAML LSP configuration
-- ----------------------------------------------------------------------------
local yaml_config = require('lspconfig.configs').yamlls

local lsp_config_callback = function(opt)
  local helm_config = require('lspconfig.configs').helm_ls

  -- Do not load if it is a Helm Chart
  local file_path = vim.api.nvim_buf_get_name(opt.buf)
  if (helm_config.get_root_dir(file_path)
        and vim.fn.fnamemodify(file_path, ':p:h:t') == 'templates'
      ) then
    return
  end

  -- Else load
  yaml_config.manager:try_add(opt.buf)
end

vim.api.nvim_create_autocmd(
  'FileType',
  {
    pattern = yaml_config.filetypes,
    callback = lsp_config_callback,
    group = vim.api.nvim_create_augroup('phdz-lspconfig-yaml', {}),
    desc = string.format(
      'Checks whether server %s should start a new instance or attach to an existing one.',
      yaml_config.name
    ),
  }
)
