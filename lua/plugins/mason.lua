return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts_extend = { "ensure_installed" },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "",
        package_uninstalled = "✗",
      },
    },
    ensure_installed = {
      "bash-language-server",
      "fish-lsp",
      "hyprls",
      "lemminx",
      "nixfmt",
      "nixpkgs-fmt",
      "rnix-lsp",
      "shellcheck",
      "ty",
    },
  },
}
