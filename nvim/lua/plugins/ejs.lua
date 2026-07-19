return {
  -- 1. FILETYPE & SYNTAX HIGHLIGHTING
  {
    "connorontheweb/ejs.nvim",
    ft = "ejs",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- Force Neovim to recognize .ejs extensions
      vim.filetype.add({ extension = { ejs = "ejs" } })

      -- Load the plugin
      require("ejs").setup({})
    end,
  },
  -- 4. File Icons (mini.icons for newer LazyVim setups)
  {
    "nvim-mini/mini.icons",
    opts = {
      extension = {
        ejs = { glyph = "", hl = "MiniIconsYellow" },
      },
      filetype = {
        ejs = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
  },
}
