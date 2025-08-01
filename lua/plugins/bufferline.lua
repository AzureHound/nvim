return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      themable = true,
      mode = "buffers", -- buffers, tabs
      numbers = "ordinal", -- buffer_id, ordinal
      separator_style = "thin", -- slant, padded_slant, slope, thick, thin
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
  },
}
