if not vim.g.neovide then
  return {}
end

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

-- Keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "i" }, "<C-+>", function()
  ResizeGuiFont(1)
end, opts)
vim.keymap.set({ "n", "i" }, "<C-->", function()
  ResizeGuiFont(-1)
end, opts)

-- Options
vim.g.neovide_padding_top = 5
vim.g.neovide_padding_right = 5
vim.g.neovide_padding_left = 7

-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end

-- Avoid transparency if hostname is "Notebook"
local hostname = vim.fn.system("uname -n"):gsub("%s+", "")
if hostname ~= "Notebook" then
  vim.g.neovide_opacity = 0.6
  vim.g.transparency = 0.6
  vim.g.neovide_background_color = "#24273a" .. alpha()
end

vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 5.0
vim.g.neovide_floating_blur_amount_y = 5.0
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10

vim.g.neovide_cursor_animation_length = 0.150
vim.g.neovide_cursor_trail_size = 1.0
vim.g.neovide_cursor_antialiasing = false
vim.g.neovide_cursor_smooth_blink = false
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_hide_mouse_when_typing = true

vim.o.guifont = "JetBrainsMono Nerd Font:h13"

vim.opt.winblend = 20
vim.g.neovide_refresh_rate = 90

return {}
