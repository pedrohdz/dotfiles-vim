return {
  'Rykka/InstantRst',
  init = function()
    -- Set global values before the plugin loads
    vim.g.instant_rst_port = 8888
    vim.g.instant_rst_localhost_only = 1
    vim.g.instant_rst_bind_scroll = 1
  end,
}
