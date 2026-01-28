return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },
  opts = function()
    local ret = {
      diagnostics = {
        virtual_text = {
          float = {
            border = {
              { "┌", "FloatBorder" },
              { "─", "FloatBorder" },
              { "┐", "FloatBorder" },
              { "│", "FloatBorder" },
              { "┘", "FloatBorder" },
              { "─", "FloatBorder" },
              { "└", "FloatBorder" },
              { "│", "FloatBorder" },
            },
          },
        },
        -- virtual_lines = {
        --   current_line = true,
        -- },
      },
      servers = {
        bashls = {},
        cssls = {},
        eslint = {},
        fish_lsp = {},
        html = {},
        lemminx = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["dlspuplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                type = {
                  castNumberToInteger = true,
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        marksman = {
          enabled = false, -- TODO: Make this dynamic & detect wether we are on an obsidian vault or a regular md file
        },
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern("tailwind.config.js", ".git")(...)
          end,
        },
      },
    }
  end,
}
