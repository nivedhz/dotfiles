return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.filetype.add({
        extension = {
          ejs = "ejs",
        },
      })
    end,
    opts = {
      servers = {
        html = {
          filetypes = { "html", "ejs" },
        },
        emmet_language_server = {
          filetypes = { "css", "html", "javascriptreact", "less", "sass", "scss", "typescriptreact", "ejs" },
        },
        emmet_ls = {
          filetypes = { "css", "html", "javascriptreact", "less", "sass", "scss", "typescriptreact", "ejs" },
        },
      },
    },
  },

  -- 2. Formatter Configuration (conform.nvim)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        prettier_ejs = {
          command = "npx",
          args = { "prettier", "--plugin", "prettier-plugin-ejs", "--parser", "html", "--stdin-filepath", "$FILENAME" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        ejs = { "prettier_ejs" },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "html", "javascript", "css" })
    end,
  },
}
