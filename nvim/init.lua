-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local handle = io.popen("bash -lc 'which node'")
local node = handle:read("*a"):gsub("%s+", "")
handle:close()

if node ~= "" then
  local node_dir = vim.fn.fnamemodify(node, ":h")
  vim.env.PATH = node_dir .. ":" .. vim.env.PATH
end
