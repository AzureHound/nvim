return {
  "RayenMnif/tgpt.nvim",
  event = "VeryLazy",
  config = function()
    local createBuffer = function()
      vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
        relative = "editor",
        anchor = "NE",
        style = "minimal",
        border = "single",
      })
    end

    local InteractiveChat = function()
      createBuffer()
      vim.api.nvim_command("startinsert")
      vim.fn.termopen("tgpt -i", {
        on_exit = function()
          local win_id = vim.api.nvim_get_current_win()
          vim.api.nvim_win_close(win_id, true)
        end,
      })
    end

    local RateMyCode = function()
      local file = vim.api.nvim_buf_get_name(0)
      local prompt = "cat " .. file .. " | tgpt 'Rate the code'"
      createBuffer()
      vim.fn.termopen(prompt)
    end

    local CheckForBugs = function()
      local file = vim.api.nvim_buf_get_name(0)
      local prompt = "cat " .. file .. " | tgpt 'Check for bugs'"
      createBuffer()
      vim.fn.termopen(prompt)
    end

    vim.api.nvim_create_user_command("Chat", InteractiveChat, { nargs = 0 })
    vim.api.nvim_create_user_command("RateMyCode", RateMyCode, { nargs = 0 })
    vim.api.nvim_create_user_command("CheckForBugs", CheckForBugs, { nargs = 0 })
  end,
}
