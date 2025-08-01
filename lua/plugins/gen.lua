return {
  {
    "David-Kunz/gen.nvim",
    event = "VeryLazy",
    opts = {
      model = "deepseek-r1:8b", -- deepseek-r1:8b, qwen2.5-coder
      quit_map = "q",
      retry_map = "<c-r>",
      accept_map = "<c-cr>",
      host = "localhost",
      port = "11434",
      display_mode = "float",
      show_prompt = false,
      show_model = false,
      no_auto_close = false,
      file = false,
      hidden = false,
      init = function(options)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,

      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      debug = false,
    },
    config = function()
      require("gen").prompts["Elaborate_Text"] = {
        prompt = "Elaborate the following text:\n$text",
        replace = true,
      }
      require("gen").prompts["Fix_Code"] = {
        prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      }
    end,
    keys = {
      { "<leader>]", "<cmd>Gen<cr>", desc = "Gen.nvim default prompt" },
      { "v", "<leader>]", "<cmd>Gen Enhance_Grammar_Spelling<cr>", desc = "Gen.nvim enhance grammar" },
      { "v", "<leader>e", "<cmd>Gen Elaborate_Text<cr>", desc = "Gen.nvim elaborate text" },
      { "v", "<leader>f", "<cmd>Gen Fix_Code<cr>", desc = "Gen.nvim fix code" },
    },
  },
}
