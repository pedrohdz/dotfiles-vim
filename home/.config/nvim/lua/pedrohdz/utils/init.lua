local M = {}

M.find_relative_project_root = function(fname)
  local util = require('lspconfig.util')

  local git_ancestor = util.find_git_ancestor(fname)
  local node_modules_ancestor = util.find_node_modules_ancestor(fname)
  local json_ancestor = util.find_package_json_ancestor(fname)

  return git_ancestor or node_modules_ancestor or json_ancestor
end

M.find_buffer_project_root = function()
  local utils = require('telescope.utils')
  return M.find_relative_project_root(utils.buffer_dir())
end

M.find_cwd_project_root = function()
  return M.find_relative_project_root(vim.fn.getcwd())
end

return M
