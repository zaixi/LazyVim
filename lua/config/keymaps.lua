-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 从 vim 继承的杂项函数 {{{
vim.cmd("source " .. vim.fn.stdpath("config") .. "/lua/config/edit.vim")
-- }}}

require("config.disable_key")

local Util = require("lazyvim.util")
local utils = require("utils")

local M = {}
M.map = {}
local map = M.map

-- floating terminal
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local Keys = require("lazy.core.handler").handlers.keys
--print(type(Keys))
--print(type(vim.inspect(Keys)))
---- print(vim.inspect(Keys))
--for index, value in pairs(Keys) do
--  print(index)
--end
--print(vim.inspect(require("lazy.core.handler").handlers.keys.managed))
--print(vim.inspect(require("lazy.core.handler").handlers.keys))
-- print(vim.inspect(Keys.resolve))

vim.cmd([[

    " vim-surround 设置
    xmap " S"
    xmap ' S'
    xmap ` S`
    xmap [ S[
    xmap ( S(
    xmap { S{
    xmap } S}
    xmap ] S]
    xmap ) S)
    " xmap > S>
]])

map.general = {}

map.general.t = {
  -- Terminal Mappings
  ["<esc><esc>"] = { "<c-\\><c-n>", "普通模式" },
  ["<C-h>"] = { "<cmd>wincmd h<cr>", " 左窗口" },
  ["<C-j>"] = { "<cmd>wincmd j<cr>", " 下窗口" },
  ["<C-k>"] = { "<cmd>wincmd k<cr>", " 上窗口" },
  ["<C-l>"] = { "<cmd>wincmd l<cr>", " 右窗口" },
  ["<C-/>"] = { "<cmd>close<cr>", "隐藏Terminal" },
  ["<c-_>"] = { "<cmd>close<cr>", "隐藏Terminal" },
}

map.general.o = {
  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  ["n"] = { "'Nn'[v:searchforward]", "下一个搜索结果", opts = { expr = true } },
  ["N"] = { "'nN'[v:searchforward]", "前一个搜索结果", opts = { expr = true } },
}

map.general.i = {
  ["<A-j>"] = { "<esc><cmd>m .+1<cr>==gi", "向下移动行" },
  ["<A-k>"] = { "<esc><cmd>m .-2<cr>==gi", "向上移动行" },

  ["<ESC>"] = { "<cmd>noh<cr><esc>", "  不高亮" },
  ["<C-s>"] = { "<cmd>w<cr><esc>", "﬚  保存文件" },

-- Add undo break-points
[","] = { ",<c-g>u"},
["."] = { ".<c-g>u"},
[";"] = { ";<c-g>u"},
}

map.general.v = {
  ["<A-j>"] = { ":move '>+1<CR>gv=gv", "向下移动行" },
  ["<A-k>"] = { ":move '<-2<CR>gv=gv", "向上移动行" },

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  ["n"] = { "'Nn'[v:searchforward]", "前一个搜索结果", opts = { expr = true } },
  ["N"] = { "'nN'[v:searchforward]", "下一个搜索结果", opts = { expr = true } },

  -- 使用 < > 在可视模式下缩进
  [">"] = { ">gv", "向右缩进" },
  ["<"] = { "<gv", "向左缩进" },

-- formatting
["<leader>cf"] = { function() Util.format({ force = true }) end, desc = "Format" },
}

map.general.n = {
  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  ["n"] = { "'Nn'[v:searchforward].'zv'", "下一个搜索结果", opts = { expr = true } },
  ["N"] = { "'nN'[v:searchforward].'zv'", "前一个搜索结果", opts = { expr = true } },

  ["<A-j>"] = { "<cmd>m .+1<cr>==", "向下移动行" },
  ["<A-k>"] = { "<cmd>m .-2<cr>==", "向上移动行" },

  -- Move to window using the <ctrl> hjkl keys
  ["<S-Up>"] = { "<cmd>resize +2<cr>", "增加窗口高度" },
  ["<S-Down>"] = { "<cmd>resize -2<cr>", "减少窗口高度" },
  ["<S-Left>"] = { "<cmd>vertical resize +2<cr>", "增加窗口宽度" },
  ["<S-Right>"] = { "<cmd>vertical resize -2<cr>", "减少窗口宽度" },

  -- general {{{
  ["<ESC>"] = { "<cmd>noh<cr><esc>", "  不高亮" },

  -- 在窗口之间切换
  ["<C-h>"] = { "<C-w>h", " 左窗口" },
  ["<C-l>"] = { "<C-w>l", " 右窗口" },
  ["<C-j>"] = { "<C-w>j", " 下窗口" },
  ["<C-k>"] = { "<C-w>k", " 上窗口" },

  ["<C-left>"] = { ":TmuxNavigateLeft <CR>", "tmux  左窗口" },
  ["<c-right>"] = { ":TmuxNavigateRight  <CR>", "tmux  右窗口" },
  ["<C-up>"] = { ":TmuxNavigateUp <CR>", "tmux  上窗口" },
  ["<c-down>"] = { ":TmuxNavigateDown <CR>", "tmux  下窗口" },

  ["<C-s>"] = { "<cmd>w<cr><esc>", "﬚  保存文件" },
  ["<C-c>"] = { "<cmd> %y+  <CR>", "复制整个文件" },

  -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
  -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
  -- empty mode is same as using <cmd> :map
  -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
  ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },
  ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
  ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
  ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },

  ["[q"] = { "vim.cmd.cprev", "上个quickfix" },
  ["]q"] = { "vim.cmd.cnext,", "下个quickfix" },

  -- ["[b"] = { "<cmd>bprevious<cr>", "切换上个buf(tab等效)" },
  -- ["]b"] = { "<cmd>bnext<cr>", "切换下个buf(tab等效)" },
  ["[b"] = { "<cmd>BufferLineCyclePrev<cr>", "切换上个buf(tab等效)" },
  ["]b"] = { "<cmd>BufferLineCycleNext<cr>", "切换下个buf(tab等效)" },

  --- buffer {{{

  -- cycle through buffers
  ["<TAB>"] = { "<leader>bn", "  下一个 buffer", opts = { remap = true } },
  ["<S-Tab>"] = { "<leader>bp", "  上一个 buffer", opts = { remap = true } },

  ["<leader>b"] = { name = "﬘  Buffers" },
  ["<leader>bd"] = { ":bd  <CR>", "删除此buffer" },
  ["<leader>bb"] = { "<cmd>Telescope buffers  <CR>", "buf 浏览器" },
  ["<leader>bn"] = { "]b", "切换下个buf(tab等效)", opts = { remap = true } },
  ["<leader>bp"] = { "[b", "切换上个buf(s-tab等效)", opts = { remap = true } },
  ["<leader>b<TAB>"] = { "<cmd>BufferLineMoveNext <CR>", "移动buf到下一个" },
  ["<leader>b<S-TAB>"] = { "<cmd>BufferLineMovePrev <CR>", "移动buf到上一个" },
  --- }}}

  -- tabs
  ["<leader><tab>"] = { name = "tabline" },
  ["<leader><tab>l"] = { "<cmd>tablast<cr>", "最后一个Tab" },
  ["<leader><tab>f"] = { "<cmd>tabfirst<cr>", "第一个Tab" },
  ["<leader><tab><tab>"] = { "<cmd>tabnew<cr>", "新Tab" },
  ["<leader><tab>]"] = { "<cmd>tabnext<cr>", "下一个Tab" },
  ["<leader><tab>d"] = { "<cmd>tabclose<cr>", "关闭Tab" },
  ["<leader><tab>["] = { "<cmd>tabprevious<cr>", "上一个Tab" },

  ["<leader>u"] = { name = "  更新/ui" },
  ["<leader>up"] = { "<cmd> Lazy <CR>", "  插件" },
  ["<leader>us"] = { "<cmd> Mason <CR>", "  LSP/DAP 服务器" },
  -- LazyVim Changelog
  ["<leader>uL"] = { function() Util.news.changelog() end, "LazyVim Changelog", },

  -- highlights under cursor
  ["<leader>ui"] = { vim.show_pos, "Inspect Pos" },

  ["<leader>fn"] = { "<cmd>enew<CR>", "  新建文件" },

  -- windows
  ["<leader>ww"] = { "<C-W>p", "其他窗口", opts = { remap = true } },
  ["<leader>wd"] = { "<C-W>c", "删除窗口", opts = { remap = true } },
  ["<leader>w-"] = { "<C-W>s", "水平拆分窗口", opts = { remap = true } },
  ["<leader>w|"] = { "<C-W>v", "竖直拆分窗口", opts = { remap = true } },
  ["<leader>-"] = { "<C-W>s", "水平拆分窗口", opts = { remap = true } },
  ["<leader>|"] = { "<C-W>v", "竖直拆分窗口", opts = { remap = true } },

  -- floating terminal
  ["<leader>ft"] = { lazyterm, "Terminal (root dir)" },
  ["<leader>fT"] = { function() Util.terminal() end, "Terminal (cwd)", },
  ["<c-/>"] = { lazyterm, "Terminal (root dir)" },
  ["<c-_>"] = { lazyterm, "Terminal (root dir)" },

  -- lazygit
  ["<leader>gg"] = { function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end,
    "Lazygit (root dir)", },
  ["<leader>gG"] = { function() Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end, "Lazygit (cwd)", },

  -- quit
  ["<leader>qq"] = { "<cmd>qa<cr>", "退出所有" },

-- toggle options
["<leader>uf"] = { function() Util.format.toggle() end, "切换自动格式化(global)" },
["<leader>uF"] = { function() Util.format.toggle(true) end, "切换自动格式化(buffer)" },
["<leader>ts"] = { function() Util.toggle("spell") end, "切换拼写检查" },
["<leader>uw"] = { function() Util.toggle("wrap") end, "切换折行" },
["<leader>tL"] = { function() Util.toggle("relativenumber") end, "切换相对行号" },
["<leader>ul"] = { function() Util.toggle.number() end, "切换行号" },
["<leader>ud"] = { function() Util.toggle.diagnostics() end, "切换诊断" },

-- diagnostic
["<leader>cd"] = { vim.diagnostic.open_float, "Line Diagnostics" },
["]d"] = { diagnostic_goto(true), "Next Diagnostic" },
["[d"] = { diagnostic_goto(false), "Prev Diagnostic" },
["]e"] = { diagnostic_goto(true, "ERROR"), "Next Error" },
["[e"] = { diagnostic_goto(false, "ERROR"), "Prev Error" },
["]w"] = { diagnostic_goto(true, "WARN"), "Next Warning" },
["[w"] = { diagnostic_goto(false, "WARN"), "Prev Warning" },

-- formatting
["<leader>cf"] = { function() Util.format({ force = true }) end, desc = "Format" },

["<leader>uc"] = { function() Util.toggle("conceallevel", false, {0, vim.o.conceallevel > 0 and vim.o.conceallevel or 3}) end,
                "Toggle Conceal" },
["<leader>uh"] = { function() vim.lsp.inlay_hint(0, nil) end, "Toggle Inlay Hints" },
["<leader>uT"]= { function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end,
              "Toggle Treesitter Highlight" },

["<leader>xl"] = { "<cmd>lopen<cr>", "Location List" },
["<leader>xq"] = { "<cmd>copen<cr>", "Quickfix List" },

--keywordprg
["<leader>K"] =  {"<cmd>norm! K<cr>", "Keywordprg" },

["<leader>ur"] = { "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    "Redraw / clear hlsearch / diff update" },

}

--utils.set_mappings(map.general)
return M
