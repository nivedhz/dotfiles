-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "<C-l>", "() => {}<Left>")
vim.keymap.set("n", "<C-k>", function()
  local diagnostics = vim.diagnostic.get(0, {
    lnum = vim.api.nvim_win_get_cursor(0)[1] - 1,
  })

  if #diagnostics > 0 then
    vim.diagnostic.open_float()
  else
    vim.lsp.buf.hover()
  end
end)
vim.keymap.set("n", "<leader>ge", function()
  vim.diagnostic.jump({ count = 1 })
end)

vim.keymap.set("n", "<leader>gE", function()
  vim.diagnostic.jump({ count = -1 })
end)
