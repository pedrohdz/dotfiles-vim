return {
  "lewis6991/gitsigns.nvim",
  version = '>1',
  config = function()
    require("gitsigns").setup({
      on_attach = function(buffer_num)
        -- Ignore diffs
        local window_id = vim.fn.win_getid(vim.fn.bufwinnr(buffer_num))
        if vim.wo[window_id].diff then
          return false
        end
      end,
    })
  end,
}
