------
-- InstantRst
--   - https://github.com/Rykka/InstantRst
--   - https://github.com/rykka/instant-rst.py
------
--let instant_rst_site = fnamemodify(expand("$MYVIMRC"), ":p:h") . '/.vim/sites/instant-rst'
--vim.g.instant_rst_template = instant_rst_site . '/templates'
--vim.g.instant_rst_static = instant_rst_site . '/static'
vim.g.instant_rst_port = 8888
vim.g.instant_rst_localhost_only = 1
vim.g.instant_rst_bind_scroll = 1
