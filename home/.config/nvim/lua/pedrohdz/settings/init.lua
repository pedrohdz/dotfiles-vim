vim.opt.autowrite = true
vim.opt.encoding = 'utf-8'
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'marker'
vim.opt.formatoptions = 'tcq'
vim.opt.hidden = true
vim.opt.list = true
vim.opt.listchars = { tab = '▸-', eol = '¬', trail = '·' }
vim.opt.modeline = true
vim.opt.modelines = 5
vim.opt.number = false
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.textwidth = 79
vim.opt.title = true
vim.opt.ttyfast = true
vim.opt.visualbell = false
vim.opt.wildmode = { list = 'longest' }
vim.opt.wrap = false

if vim.fn.has('mouse') then
  vim.opt.mouse = 'a'
end

-- Backups
vim.opt.undolevels = 1000
vim.opt.backup = true
vim.opt.directory = '.'

-- FIXME - Replace with shada?
-- vim.o.viminfo = '500,:1000,/1000,f1,n~/.nviminfo'

-- Searching
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.hlsearch = true

-- Popup menu behavior
-- OLD - vim.opt.completeopt=longest,menu
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.pumheight = 20

vim.g.mapleader = '\\'
vim.g.maplocalleader = ' '

-- For use with the CursorHold autocmd event with vim.diagnostic.open_float().
vim.opt.updatetime = 250 -- msec
