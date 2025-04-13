-- ----------------------------------------------------------------------------
-- Color Scheme configurations
-- ----------------------------------------------------------------------------
-- jellybeans
--    https://github.com/nanotech/jellybeans.vim
vim.g.jellybeans_use_term_italics = 0
-- let g:jellybeans_use_lowcolor_black = 1

-- `background` set to allow transparent backgrounds, image backgrounds, or a
-- different color) instead of the background color that Jellybeans applies.
--
--   - https://github.com/nanotech/jellybeans.vim#terminal-background
--
vim.g.jellybeans_overrides = {
  background = {
    guibg = 'none',
    ctermbg = 'none',
    ['256ctermbg'] = 'none',
  }
}


-- gruvbox
--    https://github.com/morhetz/gruvbox
-- Configuration options found in:
--   - https://github.com/morhetz/gruvbox/wiki/Configuration
vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_contrast_light = "hard"
vim.g.gruvbox_bold = 1
vim.g.gruvbox_improved_strings = 0
vim.g.gruvbox_improved_warnings = 0


-- solarized
--    https://github.com/altercation/vim-colors-solarized
vim.g.solarized_termcolors = 256
vim.g.solarized_contrast = 'high'
vim.g.solarized_termtrans = 1


-- ----------------------------------------------------------------------------
-- Other
-- ----------------------------------------------------------------------------
-- colorsel - color scheme switcher
--    https://github.com/vim-scripts/colorsel.vim
vim.g.colorscheme_switcher_exclude_builtins = 1
