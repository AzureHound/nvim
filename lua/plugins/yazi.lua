return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  opts = {
    open_for_directories = false,
    floating_window_scaling_factor = 0.9,
    yazi_floating_window_border = "rounded",
  },
  keys = {
    { "=", "<cmd>Yazi<cr>", desc = "Yazi (Current File)" },
    { "<leader>E", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)" },
    -- { "<a-e>", "<cmd>Yazi toggle<cr>", desc = "Resume Last Yazi Session" },
  },
}
