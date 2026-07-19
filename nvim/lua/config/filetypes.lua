-- ~/.config/nvim/lua/config/filetypes.lua
vim.filetype.add({
  extension = {
    ejs = "ejs",
  },
})

require("nvim-web-devicons").set_icon({
  ejs = {
    icon = "", -- You can change this to any Nerd Font icon you prefer
    color = "#cbcb41", -- Yellowish color matching EJS branding
    cterm_color = "185",
    name = "Ejs",
  },
})
