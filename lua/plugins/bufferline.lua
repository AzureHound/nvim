return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- buffers, tabs
        themable = true,
        numbers = "ordinal", -- buffer_id, ordinal, both
        separator_style = "thin", -- slant, padded_slant, slope, thick, thin

        -- Visuals
        color_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,

        -- Buffers
        always_show_bufferline = false,
        persist_buffer_sort = true,
        move_wraps_at_ends = false,
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,

        -- Icons
        buffer_close_icon = "󰅖",
        modified_icon = "● ",
        close_icon = " ",
        left_trunc_marker = " ",
        right_trunc_marker = " ",

        -- Mouse interactions
        left_mouse_command = "buffer %d",
        right_mouse_command = "bdelete! %d",
        middle_mouse_command = nil,
        close_command = "bdelete! %d",

        -- Hover
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },

        -- Diagnostics
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_update_on_event = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,

        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(result, { text = " " .. error, link = "DiagnosticError" })
            end
            if warning ~= 0 then
              table.insert(result, { text = " " .. warning, link = "DiagnosticWarn" })
            end
            if hint ~= 0 then
              table.insert(result, { text = "" .. hint, link = "DiagnosticHint" })
            end
            if info ~= 0 then
              table.insert(result, { text = " " .. info, link = "DiagnosticInfo" })
            end
            return result
          end,
        },
      },

      -- Highlights
      highlights = {
        close_button = {
          fg = "#f38ba8",
        },
        close_button_selected = {
          bold = true,
          fg = "#f38ba8",
        },
        close_button_visible = {
          fg = "#f38ba8",
        },
      },
    })

    -- Key mappings
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Buffer management
    keymap("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", vim.tbl_extend("force", opts, { desc = "Toggle Pin" }))
    keymap(
      "n",
      "<leader>bP",
      "<cmd>BufferLineGroupClose ungrouped<cr>",
      vim.tbl_extend("force", opts, { desc = "Delete Non-Pinned Buffers" })
    )
    keymap(
      "n",
      "<leader>bo",
      "<cmd>BufferLineCloseOthers<cr>",
      vim.tbl_extend("force", opts, { desc = "Delete Other Buffers" })
    )
    keymap(
      "n",
      "<leader>br",
      "<cmd>BufferLineCloseRight<cr>",
      vim.tbl_extend("force", opts, { desc = "Delete Buffers to the Right" })
    )
    keymap(
      "n",
      "<leader>bl",
      "<cmd>BufferLineCloseLeft<cr>",
      vim.tbl_extend("force", opts, { desc = "Delete Buffers to the Left" })
    )

    -- Buffer picking
    keymap("n", "<leader>bb", "<cmd>BufferLinePick<cr>", vim.tbl_extend("force", opts, { desc = "Pick Buffer" }))
    keymap(
      "n",
      "<leader>bd",
      "<cmd>BufferLinePickClose<cr>",
      vim.tbl_extend("force", opts, { desc = "Pick Buffer to Delete" })
    )

    -- Go to specific buffers {1-9}
    for i = 1, 9 do
      keymap(
        "n",
        "<leader>" .. i,
        "<cmd>BufferLineGoToBuffer " .. i .. "<cr>",
        vim.tbl_extend("force", opts, { desc = "Go to Buffer " .. i })
      )
    end
    keymap(
      "n",
      "<leader>$",
      "<cmd>BufferLgit stash apply stash@{0}ineGoToBuffer -1<cr>",
      vim.tbl_extend("force", opts, { desc = "Go to Last Buffer" })
    )

    -- Moving
    keymap(
      "n",
      "<leader>bmn",
      "<cmd>BufferLineMoveNext<cr>",
      vim.tbl_extend("force", opts, { desc = "Move Buffer Next" })
    )
    keymap(
      "n",
      "<leader>bmp",
      "<cmd>BufferLineMovePrev<cr>",
      vim.tbl_extend("force", opts, { desc = "Move Buffer Prev" })
    )

    -- Sorting
    keymap(
      "n",
      "<leader>bse",
      "<cmd>BufferLineSortByExtension<cr>",
      vim.tbl_extend("force", opts, { desc = "Sort by Extension" })
    )
    keymap(
      "n",
      "<leader>bsd",
      "<cmd>BufferLineSortByDirectory<cr>",
      vim.tbl_extend("force", opts, { desc = "Sort by Directory" })
    )
    keymap(
      "n",
      "<leader>bst",
      "<cmd>BufferLineSortByTabs<cr>",
      vim.tbl_extend("force", opts, { desc = "Sort by Tabs" })
    )
  end,
}
