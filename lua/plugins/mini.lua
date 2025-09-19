return {
  {
    "nvim-mini/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- splitjoin
      require("mini.splitjoin").setup({
        mappings = { toggle = "" },
      })

      vim.keymap.set({ "n", "x" }, "sj", function()
        require("mini.splitjoin").join()
      end, { desc = "Join arguments" })

      vim.keymap.set({ "n", "x" }, "sk", function()
        require("mini.splitjoin").split()
      end, { desc = "Split arguments" })

      -- surround
      require("mini.surround").setup({
        custom_surroundings = nil,
        highlight_duration = 300,

        -- Module mappings. Use `''` (empty string) to disable one.
        -- INFO:
        -- saiw surround with no whitespace
        -- saw surround with whitespace
        mappings = {
          add = "sa", -- Add surrounding in Normal and Visual modes
          delete = "ds", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "sr", -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`
          suffix_last = "l", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },
        n_lines = 20,
        respect_selection_type = false,
        search_method = "cover",
        silent = false,
      })

      -- whitespace
      require("mini.trailspace").setup({
        only_in_normal_buffers = true,
      })

      vim.keymap.set("n", "<leader>cw", function()
        require("mini.trailspace").trim()
      end, { desc = "Erase Whitespace" })

      vim.api.nvim_create_autocmd("CursorMoved", {
        pattern = "*",
        callback = function()
          require("mini.trailspace").unhighlight()
        end,
      })
    end,
  },
}
