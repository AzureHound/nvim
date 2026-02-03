local prefix = "<leader>o"

return {
  {
    "obsidian-nvim/obsidian.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- ft = "markdown",
    event = "BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md",
    keys = {
      { prefix .. "o", "<cmd>Obsidian open<CR>", desc = "Open on App" },
      { prefix .. "g", "<cmd>Obsidian search<CR>", desc = "Grep" },
      { prefix .. "n", "<cmd>Obsidian new<CR>", desc = "New Note" },
      { prefix .. "N", "<cmd>Obsidian new_from_template<CR>", desc = "New Note (Template)" },
      { prefix .. "<space>", "<cmd>Obsidian quick_switch<CR>", desc = "Find Files" },
      { prefix .. "b", "<cmd>Obsidian backlinks<CR>", desc = "Backlinks" },
      { prefix .. "t", "<cmd>Obsidian tags<CR>", desc = "Tags" },
      { prefix .. "T", "<cmd>Obsidian template<CR>", desc = "Template" },
      { prefix .. "L", "<cmd>Obsidian link<CR>", mode = "v", desc = "Link" },
      { prefix .. "l", "<cmd>Obsidian links<CR>", desc = "Links" },
      { prefix .. "l", "<cmd>Obsidian link_new<CR>", mode = "v", desc = "New Link" },
      { prefix .. "e", "<cmd>Obsidian extract_note<CR>", mode = "v", desc = "Extract Note" },
      { prefix .. "w", "<cmd>Obsidian workspace<CR>", desc = "Workspace" },
      { prefix .. "r", "<cmd>Obsidian rename<CR>", desc = "Rename" },
      { prefix .. "i", "<cmd>Obsidian paste_img<CR>", desc = "Paste Image" },
      { prefix .. "d", "<cmd>Obsidian dailies<CR>", desc = "Daily Notes" },
    },
    opts = {
      workspaces = {
        {
          name = "Personal",
          path = "~/Obsidian/Personal",
        },
        {
          name = "Proffesional",
          path = "~/Obsidian",
        },
      },
      notes_subdir = "Notes",
      new_notes_location = "notes_subdir",
      preferred_link_style = "wiki",
      open_notes_in = "current",
      templates = {
        folder = "Templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
      completion = {
        blink = true,
        nvim_cmp = false,
      },
      picker = {
        name = "snacks.pick",
        note_mappings = {
          new = "<C-x>",
          insert_link = "<C-l>",
        },
        tag_mappings = {
          tag_note = "<C-x>",
          insert_tag = "<C-l>",
        },
      },
      daily_notes = {
        folder = "Dailies",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        default_tags = { "daily-notes" },
        template = nil,
      },
      checkbox = {
        enabled = true,
        create_new = true,
        order = { " ", "~", "!", ">", "x" },
      },
      ui = {
        enable = false,
        ignore_conceal_warn = false,
        update_debounce = 200,
        max_file_length = 5000,
        checkbox = {
          [" "] = { char = "󰄱 ", hl_group = "ObsidianTodo" },
          ["~"] = { char = "󰰱 ", hl_group = "ObsidianTilde" },
          ["!"] = { char = "  ", hl_group = "ObsidianImportant" },
          [">"] = { char = " ", hl_group = "ObsidianRightArrow" },
          ["x"] = { char = "✔ ", hl_group = "ObsidianDone" },
        },
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = " ", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          ObsidianTodo = { bold = true, fg = "#f5a97f" },
          ObsidianDone = { bold = true, fg = "#8aadf4" },
          ObsidianRightArrow = { bold = true, fg = "#f5a97f" },
          ObsidianTilde = { bold = true, fg = "#ee99a0" },
          ObsidianImportant = { bold = true, fg = "#ed8796" },
          ObsidianBullet = { bold = true, fg = "#8aadf4" },
          ObsidianRefText = { underline = true, fg = "#c6a0f6" },
          ObsidianExtLinkIcon = { fg = "#c6a0f6" },
          ObsidianTag = { italic = true, fg = "#8aadf4" },
          ObsidianBlockID = { italic = true, fg = "#8aadf4" },
          ObsidianHighlightText = { bg = "#eed49f" },
        },
      },
      attachments = {
        folder = "assets/imgs",
        confirm_img_paste = true,
      },
      statusline = {
        enabled = false,
        format = "Backlinks: {{backlinks}} | Words: {{words}}",
      },
      footer = {
        enabled = true,
        format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
        hl_group = "Comment",
        separator = string.rep("-", 80),
      },
      open = {
        use_advanced_uri = false,
        func = vim.ui.open,
      },
      comment = {
        enabled = false,
      },
      legacy_commands = false,
    },

    callbacks = {
      enter_note = function(client, note)
        if not note or not note.bufnr then
          return
        end
        vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<cr>", {
          buffer = note.bufnr,
          expr = note.expr,
          noremap = note.noremap,
          desc = "File Passthrough",
        })
      end,
    },

    note_id_func = function(title)
      if title == nil or title == "" then
        return os.date("%Y-%m-%d %H:%M:%S")
      else
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      end
    end,

    note_path_func = function(spec)
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,

    note_frontmatter_func = function(note)
      if note.title then
        note:add_alias(note.title)
      end

      local out = { aliases = note.aliases }

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    callback = {
      enter_note = function(note)
        vim.ui.open = (function(overridden)
          return function(uri, opt)
            if vim.endswith(uri, ".png") then
              vim.cmd("edit " .. uri)
              return
            elseif vim.endswith(uri, ".pdf") then
              opt = { cmd = { "zathura" } }
            end
            return overridden(uri, opt)
          end
        end)(vim.ui.open)
      end,
    },

    image = {
      resolve = function(path, src)
        if require("obsidian.api").path_is_note(path) then
          return require("obsidian.api").resolve_image_path(src)
        end
      end,
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        prefix .. "k",
        function()
          Snacks.picker.grep({
            search = "^\\s*- \\[ \\]",
            regex = true,
            dirs = { vim.fn.getcwd() },
            finder = "grep",
            format = "file",
            show_empty = true,
            supports_live = false,
            live = false,
          })
        end,
        desc = "Tasks (Unfinished)",
      },
      {
        prefix .. "K",
        function()
          Snacks.picker.grep({
            search = "^\\s*- \\[x\\]:",
            regex = true,
            dirs = { vim.fn.getcwd() },
            finder = "grep",
            format = "file",
            show_empty = true,
            supports_live = false,
            live = false,
          })
        end,
        desc = "Tasks (Finished)",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { prefix, group = "obsidian", icon = " ", mode = { "n", "v" } },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, "b:obsidian")
    end,
  },
}
