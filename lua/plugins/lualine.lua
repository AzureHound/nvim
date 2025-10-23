local formatter = function()
  local formatters = require("conform").list_formatters(0)
  if #formatters == 0 then
    return ""
  end

  return "󰛖 "
end

local linter = function()
  local linters = require("lint").linters_by_ft[vim.bo.filetype]
  if #linters == 0 then
    return ""
  end

  return "󱉶 "
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,

    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons
      vim.o.laststatus = vim.g.lualine_laststatus
      local opts = {
        options = {
          theme = "auto",
          component_separators = { left = "|", right = "|" },
          -- section_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        },

        sections = {
          lualine_a = { { "mode", icon = "" } },
          lualine_b = {
            {
              function()
                local branch = vim.b.gitsigns_head or vim.fn.FugitiveHead()
                if not branch or branch == "" then
                  return ""
                end

                if not _G.git_remote_data then
                  _G.git_remote_data = { icon = " ", color = "#a6da95" }

                  local remote_handle =
                    io.popen("git config branch.$(git symbolic-ref --short HEAD).remote 2>/dev/null")
                  if remote_handle then
                    local remote_name = remote_handle:read("*l")
                    remote_handle:close()

                    if remote_name and remote_name ~= "" then
                      local url_handle = io.popen("git config remote." .. remote_name .. ".url 2>/dev/null")
                      if url_handle then
                        local url = url_handle:read("*a")
                        url_handle:close()

                        if url and url ~= "" then
                          url = url:gsub("%s+", "")
                          if url:match("github%.com") then
                            _G.git_remote_data = { icon = " ", color = "#a5adcb" }
                          elseif url:match("gitlab") then
                            _G.git_remote_data = { icon = " ", color = "#f5a97f" }
                          elseif url:match("forgejo") or remote_name == "forgejo" then
                            _G.git_remote_data = { icon = " ", color = "#ee99a0" }
                          elseif url:match("bitbucket") then
                            _G.git_remote_data = { icon = " ", color = "#8aadf4" }
                          end
                        end
                      end
                    end
                  end
                end

                return _G.git_remote_data.icon
              end,
              color = function()
                if not _G.git_remote_data then
                  return { fg = "#a6da95" }
                end
                return { fg = _G.git_remote_data.color }
              end,
              padding = { left = 1, right = 0 },
              separator = "",
            },
            {
              function()
                local branch = vim.b.gitsigns_head or vim.fn.FugitiveHead()
                return branch or ""
              end,
              color = { fg = "#a6da95" },
              padding = { left = 0, right = 1 },
            },
          },
          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            Snacks.profiler.status(),
            {
              "copilot",
              symbols = {
                status = {
                  icons = {
                    enabled = " ",
                    sleep = " ",
                    disabled = " ",
                    warning = " ",
                    unknown = " ",
                  },
                  hl = {
                    enabled = "#a6da95",
                    sleep = "#8bd5ca",
                    disabled = "#a5adcb",
                    warning = "#eed49f",
                    unknown = "#ed8796",
                  },
                },
                spinners = "dots",
                spinner_color = "#a5adcb",
              },
              show_colors = true,
              show_loading = true,
            },
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Constant") }
              end,
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = function()
                return { fg = Snacks.util.color("Debug") }
              end,
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function()
                return { fg = Snacks.util.color("Special") }
              end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 1 } },
          },
          lualine_z = {
            { "location", padding = { left = 1, right = 0 } },
            {
              function()
                return "󰦨"
              end,
              padding = { left = 0, right = 1 },
            },
          },
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end
      if not vim.g.trouble_lualine then
        table.insert(opts.sections.lualine_c, { "navic", color_correction = "dynamic" })
      end
      return opts
    end,
  },
}
