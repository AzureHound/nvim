return {
  "danilamihailov/beacon.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    enabled = true,
    speed = 2,
    width = 40,
    winblend = 10, -- Transparency
    fps = 60,
    min_jump = 12,
    cursor_events = { "CursorMoved" },
    window_events = { "WinEnter", "FocusGained" },
    highlight = { bg = "white", ctermbg = 15 },
  },
}
