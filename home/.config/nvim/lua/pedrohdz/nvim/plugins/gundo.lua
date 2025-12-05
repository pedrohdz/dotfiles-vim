-- Gundo (undo-tree visualizer) ----------------------------------------------
return {
  'sjl/gundo.vim',
  cmd = 'GundoToggle',            -- lazy-load on :GundoToggle
  init = function()               -- executed before the plugin loads
    vim.g.gundo_prefer_python3 = 1
    vim.g.gundo_preview_bottom = 1
  end,
}
