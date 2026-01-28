return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "fish",
        "gitignore",
        "http",
        "requirements",
        "sql",
        "xml",
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },

    init = function()
      vim.filetype.add({
        pattern = {
          [".*kitty%.conf"] = "kitty",
          [".*/kitty/.*%.conf"] = "kitty",
        },
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").kitty = {
            install_info = {
              url = "https://github.com/OXY2DEV/tree-sitter-kitty",
            },
          }
        end,
      })
    end,
  },
}
