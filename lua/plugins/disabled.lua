local disabled = {
  -- { "folke/noice.nvim" },
  -- { "folke/trouble.nvim" },
  { "nvim-neo-tree/neo-tree.nvim" },
  -- { "nvim-lualine/lualine.nvim" },
}

for i, plugin in ipairs(disabled) do
  plugin.enabled = false
end

return disabled
