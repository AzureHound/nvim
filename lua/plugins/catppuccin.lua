return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  priority = 1000,
  opts = function()
    -- Workaround for bufferline compatibility
    local ok, module = pcall(require, "catppuccin.groups.integrations.bufferline")
    if ok and module and not module.get and type(module.get_theme) == "function" then
      module.get = module.get_theme
    end

    return {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      background = {
        light = "frappe",
        dark = "macchiato",
      },
      transparent_background = true,
      float = {
        transparent = true,
        solid = false,
      },
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {},
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      auto_integrations = false,
      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        nvimtree = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    }
  end,
}
