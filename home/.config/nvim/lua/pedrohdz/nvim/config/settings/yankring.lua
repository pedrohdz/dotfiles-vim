-- YankRing is a little broken and needs that the settings be provided before
-- loading the plugin.
--
-- let g:yankring_history_dir = stdpath('data')
vim.g.yankring_history_dir = vim.fn.stdpath('data')
