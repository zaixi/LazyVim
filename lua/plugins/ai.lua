local function switch(shell_func)
  -- [LINK] https://github.com/Kurama622/dotfiles/blob/main/zsh/module/func.zsh
  local p = io.popen(string.format("source ~/.config/zsh/module/func.zsh; %s; echo $LLM_KEY", shell_func))
  if not p then
    vim.notify("failed to get llm key", vim.log.levels.ERROR)
    return " "
  end
  local key = p:read()
  p:close()
  return key
end

local function local_llm_streaming_handler(chunk, line, assistant_output, bufnr, winid, F)
  if not chunk then
    return assistant_output
  end
  local tail = chunk:sub(-1, -1)
  if tail:sub(1, 1) ~= "}" then
    line = line .. chunk
  else
    line = line .. chunk
    local status, data = pcall(vim.fn.json_decode, line)
    if not status or not data.message.content then
      return assistant_output
    end
    assistant_output = assistant_output .. data.message.content
    F.WriteContent(bufnr, winid, data.message.content)
    line = ""
  end
  return assistant_output
end

local function local_llm_parse_handler(chunk)
  local assistant_output = chunk.message.content
  return assistant_output
end

return
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "echasnovski/mini.diff" },
    cmd = { "LLMSesionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      local tools = require("llm.common.tools")
      require("llm").setup({
        url = "https://api.deepseek.com/chat/completions",
        model = "deepseek-chat",
        api_type = "openai",
        max_tokens = 4096,
        temperature = 0.3,
        top_p = 0.7,

        prompt = "You are a helpful Chinese assistant.",

        prefix = {
          user = { text = "  ", hl = "Title" },
          assistant = { text = "  ", hl = "Added" },
        },

        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },
        },
        display = {
          diff = {
            layout = "vertical", -- vertical|horizontal split for default provider
            opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            provider = "mini_diff", -- default|mini_diff
          },
        },
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        -- popup window options
        popwin_opts = {
          relative = "cursor", enter = true,
          focusable = true, zindex = 50,
          position = { row = -7, col = 15, },
          size = { height = 15, width = "50%", },
          border = { style = "single",
            text = { top = " Explain ", top_align = "center" },
          },
          win_options = {
            winblend = 0,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        app_handler = {
          OptimizeCode = {
            handler = tools.side_by_side_handler,
            opts = {
              -- streaming_handler = local_llm_streaming_handler,
              left = {
                focusable = false,
              },
            },
            prompt = "You are an AI programming assistant. optimized the following code, and answer in Chinese",
          },
          TestCode = {
            handler = tools.side_by_side_handler,
            prompt = [[Write some test cases for the following code, only return the test cases.
            Give the code content directly, do not use code blocks or other tags to wrap it.]],
            opts = {
              right = {
                title = " Test Cases ",
              },
            },
          },
          OptimCompare = {
            handler = tools.action_handler,
            opts = {
                temperature = 0,
            },
            prompt = "You are an AI programming assistant. optimized the following code, and answer in Chinese",
          },

          DocString = {
            prompt = [[You are an AI programming assistant. You need to write a really good docstring that follows a best practice for the given language.

Your core tasks include:
- parameter and return types (if applicable).
- any errors that might be raised or returned, depending on the language.
- 

You must:
- Place the generated docstring before the start of the code.
- Follow the format of examples carefully if the examples are provided.
- Use Doxygen formatting in your answers.
- 
- Include the programming language name at the start of the Markdown code blocks.]],
            handler = tools.action_handler,
            opts = {
              only_display_diff = true,
              templates = {
                lua = [[- For the Lua language, you should use the LDoc style.
- Start all comment lines with "---".
]],
              },
            },
          },
          Translate = {
            handler = tools.qa_handler,
            opts = {

              component_width = "60%",
              component_height = "50%",
              query = {
                title = " 󰊿 Trans ",
                hl = { link = "Define" },
              },
              input_box_opts = {
                size = "15%",
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
              preview_box_opts = {
                size = "85%",
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
            },
          },

          -- check siliconflow's balance
          UserInfo = {
            handler = function()
              local key = os.getenv("LLM_KEY")
              local res = tools.curl_request_handler(
                "https://api.deepseek.com/user/balance",
                { "GET", "-H", string.format("'Authorization: Bearer %s'", key) }
              )
              if res ~= nil then
                local info = res.balance_infos[1]
                print(string.format("Balance(%s): %f", info.currency, info.total_balance))
              end
            end,
          },
          CodeExplain = {
            handler = tools.flexi_handler,
            prompt = "Explain the following code, please only return the explanation, and answer in Chinese",
            opts = {
              enter_flexible_window = true,
            },
          },
          CommitMsg = {
            handler = tools.flexi_handler,
            prompt = function()
              return string.format(
                [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:
1. Start with an action verb (e.g., feat, fix, refactor, chore, etc.), followed by a colon.
2. Briefly mention the file or module name that was changed.
3. Describe the specific changes made.

Examples:
- feat: update common/util.py, added test cases for util.py
- fix: resolve bug in user/auth.py related to login validation
- refactor: optimize database queries in models/query.py

Based on this format, generate appropriate commit messages. Respond with message only. DO NOT format the message in Markdown code blocks, DO NOT use backticks:

```diff
%s
```
]],
                vim.fn.system("git diff --no-ext-diff --staged")
              )
            end,

            opts = {
              enter_flexible_window = true,
              apply_visual_selection = false,
              win_opts = {
                relative = "editor",
                position = "50%",
              },
              accept = {
                mapping = {
                  mode = "n",
                  keys = "<cr>",
                },
                action = function()
                  local contents = vim.api.nvim_buf_get_lines(0, 0, -1, true)
                  vim.api.nvim_command(string.format('!git commit -m "%s"', table.concat(contents)))
                end,
              },
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>ts", mode = "x", "<cmd>LLMSelectedTextHandler 英译汉<cr>", desc = "翻译选择文本" },
      { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "切换对话界面" },
      --{ "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>", desc = "解释代码" },
      { "<leader>aT", mode = "n", "<cmd>LLMAppHandler Translate<cr>", desc = "翻译" },
      { "<leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>", desc = "解释代码" },
      { "<leader>ad", mode = "v", "<cmd>LLMAppHandler DocString<cr>", desc = "生成docstring" },
      { "<leader>ag", mode = "n", "<cmd>LLMAppHandler CommitMsg<cr>", desc = "生成commit信息" },
      { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>", desc = "优化代码" },
      --{ "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>", desc = "优化代码" },
      { "<leader>au", mode = "n", "<cmd>LLMAppHandler UserInfo<cr>", desc = "API余额" },
    },
  }

