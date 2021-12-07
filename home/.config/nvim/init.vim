set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let g:coq_settings = { 'auto_start': 'shut-up' }

lua << EOF
local lsp = require "lspconfig"
local coq = require "coq"

-- Available language servers can be found at:
--   https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#java_language_server

-- ansible
require'lspconfig'.ansiblels.setup{}
lsp.ansiblels.setup(coq.lsp_ensure_capabilities())

-- bashls
require'lspconfig'.bashls.setup{}
lsp.bashls.setup(coq.lsp_ensure_capabilities())

-- docker
require'lspconfig'.dockerls.setup{}
lsp.dockerls.setup(coq.lsp_ensure_capabilities())

-- json
require'lspconfig'.jsonls.setup{}
lsp.jsonls.setup(coq.lsp_ensure_capabilities())

-- pyright
require'lspconfig'.pyright.setup{}
lsp.pyright.setup(coq.lsp_ensure_capabilities())

-- ruby (solargraph)
require'lspconfig'.solargraph.setup{}
lsp.solargraph.setup(coq.lsp_ensure_capabilities())

-- rust
require'lspconfig'.rust_analyzer.setup{}
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities())

-- terraform
require'lspconfig'.terraformls.setup{}
lsp.terraformls.setup(coq.lsp_ensure_capabilities())

-- yaml
require('lspconfig').yamlls.setup{}
lsp.yamlls.setup(coq.lsp_ensure_capabilities())

EOF
