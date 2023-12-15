local map = require("utils.replace_keys").add_replace_keys
local del = require("utils.replace_keys").del_keymap
local def_map = require("utils.replace_keys").def_map
vim.cmd('source ' .. vim.fn.stdpath("config") .. '/lua/config/edit.vim')

-- lewis6991/gitsigns.nvim

-- git {{{
-- lazygit
map({lhs = "<leader>gg", desc = "Lazygit (root dir)"}, { "<leader>gg", "Lazygit (root dir)" })
map({lhs = "<leader>gG", desc = "Lazygit (cwd)" }, { "<leader>gG", "Lazygit (cwd)" })
-- git
map({ lhs = "<leader>gc", desc = "commits" }, { "<leader>gc", "commits" })
map({ lhs = "<leader>gs", desc = "status" }, { "<leader>gs", "status" })
map({lhs = "<leader>ge", desc = "Git explorer"}, {"<leader>ge", "Git explorer"})
-- gitsigns
def_map("<leader>gn", "<cmd>Gitsigns next_hunk<CR>", "Next Hunk")
def_map("<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", "Prev Hunk")
def_map("<leader>gh", nil, 'hunks')
def_map("<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk", { "n", "v" })
def_map("<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk", { "n", "v" })
def_map("<leader>ghS", "<cmd>Gitsigns stage_buffer<CR>", "Stage Buffer")
def_map("<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk")
def_map("<leader>ghR", "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer")
def_map("<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk")
def_map("<leader>gB", "<cmd>Gitsigns toggle_current_line_blame <CR>", "当前行 blame")
def_map("<leader>gb", "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>", "Blame Line")
def_map("<leader>gd", function() vim.wo.diff=false require'gitsigns'.diffthis() end, "Diff This")
def_map("<leader>gD", function() vim.wo.diff=false require'gitsigns'.diffthis("~") end, "Diff This ~")
def_map("ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk", { "o", "x" })
-- }}}

-- 注释 {{{
def_map("<leader>/", "gc", "  注释", {remap = true, mode = {"n", "x"}})
def_map("<leader>/c", "gc", "切换行注释", {remap = true, mode = {"n", "x"}})
def_map("<leader>/b", "gb", "切换块注释", {remap = true, mode = {"n", "x"}})
def_map("<leader>/f", ":Dox <CR>", "生成函数注释")
def_map("<leader>/l", ":DoxLic <CR>", "生成许可证注释")
def_map("<leader>/a", ":DoxAuthor <CR>", "生成作者注释")
-- }}}

--   更新/ui {{{
--map({lhs = "<leader>uS", desc = "切换Flash搜索"}, {"<c-s>", "Toggle Flash Search", mode = "c" })
del({"<c-s>", "Toggle Flash Search", mode = "c"})
def_map("<leader>uS", function() require("flash").toggle() end, '切换Flash搜索')
-- lazy
def_map("<leader>u", nil, '  更新/ui')
map({lhs = "<leader>um", desc = "  LSP/DAP 服务器"}, {"<leader>cm", "Mason"})
map({lhs = "<leader>ul", desc = "  插件" }, {"<leader>l", "Lazy"})
-- LazyVim Changelog
map({lhs = "<leader>uL", "LazyVim Changelog"}, { "<leader>L", "LazyVim Changelog" })
-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map({lhs = "<leader>ur", desc = "重绘/清除"}, {"<leader>ur", "Redraw / clear hlsearch / diff update"})
map({ lhs = "<leader>uC", desc = "   查找主题和预览" }, { "<leader>uC", "Colorscheme with preview" })
map({lhs = "<leader>ut", desc = "切换Treesitter上下文"}, {"<leader>ut", "Toggle Treesitter Context"})
map({lhs = "<leader>up", desc = "切换auto pairs"}, {"<leader>up", "Toggle auto pairs"})

-- highlights under cursor
map({lhs = "<leader>ui", desc = "Inspect Pos"}, { "<leader>ui", "Inspect Pos" })

-- toggle options
map({lhs = "<leader>uf", desc = "切换自动格式化(global)"}, {  "<leader>uf", "Toggle auto format (global)" })
map({lhs = "<leader>uF", desc = "切换自动格式化(buffer)"}, {  "<leader>uF", "Toggle auto format (buffer)" })
map({lhs = "<leader>us", desc = "切换拼写建议" }, { "<leader>us", "Toggle Spelling" })
map({lhs = "<leader>ud", desc = "切换Diagnostics" }, { "<leader>ud", "Toggle Diagnostics" })
map({lhs = "<leader>uc", desc = "切换隐藏文本" }, { "<leader>uc", "Toggle Conceal" })

def_map("<leader>un", nil, '切换显示换行')
def_map("<leader>und", ":e ++ff=unix <CR>", '显示dos换行')
def_map("<leader>unu", ":e ++ff=dos <CR>", '显示unix换行')
map({lhs = "<leader>unw", desc = "切换折行" }, { "<leader>uw", "Toggle Word Wrap" })
map({lhs = "<leader>unL", desc = "切换相对行号"}, { "<leader>uL", "Toggle Relative Line Numbers" })
map({lhs = "<leader>unl", desc = "关闭/显示行号" }, { "<leader>ul", "Toggle Line Numbers" })
def_map("<leader>uh", nil, '  切换高亮')
def_map("<leader>uhh", ":set cursorline! <CR>", '切换行高亮')
def_map("<leader>uhc", ":set cursorcolumn! <CR>", '切换列高亮')
def_map("<leader>uhl", ":set list! <CR>", '切换隐藏的字符')

if vim.lsp.inlay_hint then
map({lhs = "<leader>uh", desc = "Toggle Inlay Hints" }, { "<leader>uh", "Toggle Inlay Hints" })
end
map({lhs = "<leader>uT", desc = "切换Treesitter高亮"}, { "<leader>uT", "Toggle Treesitter Highlight" })

map({lhs = "<leader>uN", desc = "关闭所有notify"}, {"<leader>un","Dismiss all Notifications"})
-- }}}

--  Buffers {{{
def_map("<leader>b", nil, '﬘  Buffers')
def_map("<leader>b<TAB>", "<cmd>BufferLineMoveNext <CR>", "移动buf到下一个")
def_map("<leader>b<S-Tab>", "<cmd>BufferLineMovePrev <CR>", "移动buf到上一个")
map({lhs = "<S-TAB>", desc = "  上个 buffer"}, {"<S-h>", "Prev buffer"})
map({lhs = "<TAB>", desc = "  下个 buffer"}, {"<S-l>", "Next buffer"})
map({lhs = "<leader>bb", desc = "查找Buffer" }, { "<leader>fb", "Buffers"})
--map({lhs = "<leader>,", desc = "查找Buffer"}, {"<leader>,", "Switch Buffer"})
del({"<leader>,", "Switch Buffer"})
map({lhs = "<leader>bt", desc = "Switch to Other Buffer" }, {"<leader>bb", "Switch to Other Buffer" })
--map({lhs = "<leader>`", desc = "Switch to Other Buffer" }, {"<leader>`", "Switch to Other Buffer" })
del({"<leader>`", "Switch to Other Buffer"})
map({lhs = "<leader>bd", desc = "删除Buffer"}, {"<leader>bd", "Delete Buffer"})
map({lhs = "<leader>bD", desc = "删除Buffer(Force)"}, {"<leader>bD", "Delete Buffer (Force)"})
map({lhs = "<leader>bp", desc = "Toggle pin"}, {"<leader>bp", "Toggle pin"})
map({lhs = "<leader>bP", desc = "删除non-pinned buffers"}, {"<leader>bP", "Delete non-pinned buffers"})
map({lhs = "<leader>bo", desc = "删除其他buffers"}, {"<leader>bo", "Delete other buffers"})
map({lhs = "<leader>br", desc = "删除右边的buffers"}, {"<leader>br", "Delete buffers to the right"})
map({lhs = "<leader>bl", desc = "删除左边的buffers"}, {"<leader>bl", "Delete buffers to the left"})
-- new file
map({lhs = "<leader>bn", desc = "烙 新建 buffer" }, {"<leader>fn", "New File"})
map({lhs = "<leader>be", desc = "buf 浏览器"}, {"<leader>be", "Buffer explorer"})
-- }}}

-- 按键映射/code {{{
def_map("<leader>c", nil, '   按键映射/code')
-- diagnostic
map({lhs = "<leader>cd", desc = "Line诊断" }, {"<leader>cd", "Line Diagnostics"})
-- formatting
map({lhs = "<leader>cf", desc = "格式化"}, {"<leader>cf", "Format", mode = { "n", "v" }})
map({lhs = "<leader>cF", desc = "格式化(嵌入代码块)"}, {"<leader>cF", "Format Injected Langs", mode = { "n", "v" }})
-- }}}

--   查找/文件 {{{
def_map("<leader>f", nil, "  文件")
def_map("<leader>fs", ":SudaWrite  <CR>", "以sudo保存文件")
def_map("<leader>fS", ":SudaRead  <CR>", "以sudo读取文件")
-- file
def_map("<leader>fe", "<cmd>Neotree filesystem focus <CR>", "跳转到文件树")
map({lhs = "<leader>fl", desc = "文件树(root dir)"}, {"<leader>fe", "Explorer NeoTree (root dir)"})
map({lhs = "<leader>fL", desc = "文件树(cwd)"}, {"<leader>fE", "Explorer NeoTree (cwd)"})
map({lhs = "<leader>e", desc = "文件树(root dir)", rhs = "<leader>fl"}, {"<leader>e", "Explorer NeoTree (root dir)"})
map({lhs = "<leader>E", desc = "文件树(cwd)", rhs = "<leader>fL"}, {"<leader>E", "Explorer NeoTree (cwd)"})
-- find
def_map("<leader>fw", ":lua vim.cmd('Telescope find_files find_command=fdfind,--type,f,-p,' .. vim.fn.expand('<cfile>'))  <CR>", "查找光标下文件")
def_map("<leader>fg", "<cmd>Telescope git_files  <CR>", "查找文件(git范围)")
def_map("<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true  <CR>", "查找所有文件")
map({lhs = "<C-p>", desc = "查找文件(root dir)"}, {"<leader><space>", "Find Files (root dir)"})
map({ lhs = "<leader>fc", desc = "查找Config文件" }, { "<leader>fc", "Find Config File" })
map({ lhs = "<leader>ff", desc = "查找文件(root dir)" }, { "<leader>ff", "Find Files (root dir)" })
map({ lhs = "<leader>fF", desc = "查找文件(cwd)" }, { "<leader>fF", "Find Files (cwd)" })
map({ lhs = "<leader>fr", desc = "查找近期文件" }, { "<leader>fr", "Recent" })
map({ lhs = "<leader>fR", desc = "查找近期文件(cwd)" }, { "<leader>fR", "Recent (cwd)" })
-- }}}

-- {{{ floating terminal
map({lhs = "<leader>ft", desc = "  新终端(root dir)"}, { "<leader>ft", "Terminal (root dir)" })
map({lhs = "<leader>fT", desc = "  新终端(cwd)" }, { "<leader>fT", "Terminal (cwd)" })
map({lhs = "<c-/>", desc = "  新终端(root dir)"}, {"<c-/>", "Terminal (root dir)" })
map({lhs = "<c-_>", desc = "  新终端(root dir)" }, { "<c-_>", "which_key_ignore" })
map({lhs = "<C-/>", desc = "Hide Terminal" }, {"<C-/>", "Hide Terminal" , mode = "t"})
map({lhs = "<c-_>", desc = "which_key_ignore" }, {"<c-_>", "which_key_ignore" , mode = "t"})
--- }}}

-- 跳转 {{{
def_map("<leader>j", nil, '+ﭠ  跳转')
def_map("<leader>jj", function ()
    require("flash").jump({
        search = { forward = true, wrap = true, multi_window = false },
    })
end, "按一个字符跳")
def_map("<leader>jp", "/", "按Pattern跳", {remap = true})
map({lhs = "s", desc = "按字符跳"}, {"s", "Flash", mode = { "n", "x", "o" }})
map({lhs = "S", desc = "按Treesitter跳"}, {"S", "Flash Treesitter", mode = { "n", "x", "o" }})
map({lhs = "r", desc = "远程操作(operator模式)"}, {"r", "Remote Flash", mode = "o"})
map({lhs = "R", desc = "远程Treesitter操作(operator模式)"}, {"R", "Treesitter Search", mode = { "o", "x" }})
-- }}}

-- tag/标签 {{{
def_map("<leader>m", nil, '  tag/标签')
def_map("<leader>mm", nil, '标签')
def_map("<leader>mma", "<Plug>(Marks-setnext)", "添加标签")
def_map("<leader>mmd", "<Plug>(Marks-deleteline)", "删除当前标签")
def_map("<leader>mmD", "<Plug>(Marks-deletebuf)", "删除所有标签")
def_map("<leader>mmn", "<Plug>(Marks-prev)", "上一个标签")
def_map("<leader>mmp", "<Plug>(Marks-next)", "下一个标签")
def_map("<leader>mmm", ":lua require'marks'.mark_state:all_to_list('quickfixlist') vim.cmd('Telescope quickfix') <CR>", "查找mark")
def_map("<leader>mt", ":GscopeSwitchLayout <CR>", "切换 scope layout")
def_map("<leader>ms", ":GscopeFind s <C-R><C-W> <CR>", "查找符号")
def_map("<leader>mg", ":GscopeFind g <C-R><C-W> <CR>", "查找定义")
def_map("<c-]>", ":Telescope lsp_handlers target=definitions <CR>", "查找定义")
def_map("<leader>mr", ":GscopeFind c <C-R><C-W> <CR>", "查找引用")
def_map("<leader>mf", ":GscopeFind f <C-R>=expand('<cfile>')<cr><cr>", "查找文件")
def_map("<leader>ma", ":GscopeFind a <C-R><C-W> <CR>", "查找赋值")
--keywordprg
map({lhs = "<leader>mK", desc = "在vimdoc/man中查找当前词" }, {"<leader>K", "Keywordprg"})
-- }}}

--    搜索/符号{{{
del({"<leader>/", "Grep (root dir)"})
del({"<leader>:", "Command History"})
def_map("<leader>s", nil, '  搜索/符号')
map({ lhs = "<leader>ss", desc = "查找定义" }, { "<leader>ss", "Goto Symbol" })
map({ lhs = "<leader>sS", desc = "查找定义(Workspace)" }, { "<leader>sS", "Goto Symbol (Workspace)" })
-- search
def_map("<leader>se", "<cmd>Telescope <CR>", "Telescope")
def_map("<leader>sq", "<cmd>Telescope quickfix <CR>", "quickfix查找")
map({ lhs = '<leader>s"', desc = "寄存器" }, { '<leader>s"', "Registers" })
map({ lhs = "<leader>sa", desc = "自动命令" }, { "<leader>sa", "Auto Commands" })
map({ lhs = "<leader>sb", desc = "Buffer" }, { "<leader>sb", "Buffer" })
map({ lhs = "<leader>sc", desc = "命令历史" }, { "<leader>sc", "Command History" })
map({ lhs = "<leader>sC", desc = "命令" }, { "<leader>sC", "Commands" })
map({ lhs = "<leader>sd", desc = "Document diagnostics" }, { "<leader>sd", "Document diagnostics" })
map({ lhs = "<leader>sD", desc = "Workspace diagnostics" }, { "<leader>sD", "Workspace diagnostics" })
map({ lhs = "<leader>sg", desc = "实时查找(root dir)" }, { "<leader>sg", "Grep (root dir)" })
map({ lhs = "<leader>sG", desc = "实时查找(cwd)" }, { "<leader>sG", "Grep (cwd)" })
map({ lhs = "<leader>sh", desc = "Help Pages" }, { "<leader>sh", "Help Pages" })
map({ lhs = "<leader>sH", desc = "高亮组" }, { "<leader>sH", "Search Highlight Groups" })
map({ lhs = "<leader>sk", desc = "查找keymap" }, { "<leader>sk", "Key Maps" })
def_map("<leader>sK", ":WhichKey <CR>", "WhichKey 查找映射")
map({ lhs = "<leader>sM", desc = "Man Pages" }, { "<leader>sM", "Man Pages" })
map({ lhs = "<leader>sm", desc = "查找mark" }, { "<leader>sm", "Jump to Mark" })
map({ lhs = "<leader>so", desc = "Options" }, { "<leader>so", "Options" })
map({ lhs = "<leader>sR", desc = "Resume" }, { "<leader>sR", "Resume" })
def_map("<leader><space>", "<leader>sw", "查找当前符号", {remap = true})
map({ lhs = "<leader>sw", desc = "查找当前符号(root dir)" }, { "<leader>sw", "Word (root dir)" })
map({ lhs = "<leader>sW", desc = "查找当前符号(cwd)" }, { "<leader>sW", "Word (cwd)" })
map({ lhs = "<leader>sw", desc = "查找字符串(root dir)" }, { "<leader>sw", "Selection (root dir)", mode = "v" })
map({ lhs = "<leader>sW", desc = "查找字符串(cwd)" }, { "<leader>sW", "Selection (cwd)", mode = "v" })
-- noice
map({lhs = "<leader>snl", desc = "Noice Last Message"}, {"<leader>snl", "Noice Last Message"})
map({lhs = "<leader>snh", desc = "Noice History"}, {"<leader>snh", "Noice History"})
map({lhs = "<leader>sna", desc = "Noice All"}, {"<leader>sna", "Noice All"})
map({lhs = "<leader>snd", desc = "Dismiss All"}, {"<leader>snd", "Dismiss All"})

map({lhs = "<leader>st", desc = "Todo"}, {"<leader>st", "Todo"})
map({lhs = "<leader>sT", desc = "Todo/Fix/Fixme"}, {"<leader>sT", "Todo/Fix/Fixme"})

map({lhs = "<leader>sr", rhs = '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',desc = "正则搜索替换"}, {"<leader>sr", "Replace in files (Spectre)"})
def_map("<leader>sr", '<esc><cmd>lua require("spectre").open_visual()<CR>', "正则搜索替换", {mode = { "x", "v" }})
-- }}}

--    切换 {{{
def_map("<leader>t", nil, '  切换')
def_map("<leader>ts", "<cmd>Translate ZH -output=floating  <CR>", "翻译选择文本", "v")

map({lhs = "<leader>tt", desc = "标签浏览"}, {"<leader>cs", "Symbols Outline"})
map({lhs = "<leader>tP", desc = "markdown预览"}, {"<leader>cp", "Markdown Preview"})

def_map("<leader>tm", ":call ToggleMouseCopy() <CR>",  '切换鼠标粘贴')

def_map("<leader>ta", "<cmd>EasyAlign <CR>", "  文本对齐", "v")
def_map("<leader>td", nil, '删除')
def_map("<leader>td ", ":lua vim.fn.Delete_extra_space() <CR>", "删除光标周围的额外空格")
def_map("<leader>tdw", ":StripWhitespace <CR>", "删除行尾空格")
def_map("<leader>ti", nil, '改变符号风格')
def_map("<leader>tic", ":CamelB <CR>", "转换为小驼峰法")
def_map("<leader>tiC", ":CamelB <CR>", "转换为大驼峰法")
def_map("<leader>ti-", ":Kebab <CR>", "转换为中划线(-)法")
def_map("<leader>ti_", ":Snek <CR>", "转换为下划线(_)法")
def_map("<leader>tiU", ":Screm <CR>", "转换为宏定义")
def_map("<leader>t<tab>", nil, 'Tab和SPC转换')
def_map("<leader>t<tab><tab>", ":lua vim.fn.Spa2Tab() <CR>", "空格转Tab")
def_map("<leader>t<tab><space>", ":lua vim.fn.Tab2Spa() <CR>", "Tab转空格")

def_map("<leader>tr", nil, '整词替换')
def_map("<leader>tR", nil, '非整词替换')
def_map("<leader>trc", ":call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>", "询问替换")
def_map("<leader>trw", ":call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>", "直接替换")
def_map("<leader>tRc", ":call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>", "询问替换")
def_map("<leader>tRw", ":call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>", "直接替换")

def_map("<leader>tu", ":UndotreeToggle <CR>", "撤销树")
def_map("<leader>ty", ":call copy2system() <CR>", "复制到系统")
def_map("<leader>tp", ":call paste2system() <CR>", "从系统粘贴")
-- }}}

-- 窗口 {{{
def_map("<leader>w", nil, '  窗口')
map({lhs = "<leader>wE", desc = "窗口选择"}, {"<leader>uE", "Edgy Select Window"})
map({lhs = "<leader>we", desc = "Edgy窗口切换"}, {"<leader>ue", "Edgy Toggle"})
-- windows
map({lhs = "<leader>ww", desc = "上一个窗口"}, {"<leader>ww", "Other window"})
map({lhs = "<leader>wd", desc = "删除窗口"}, {"<leader>wd", "Delete window"})
map({lhs = "<leader>w-", desc = "向右拆分窗口"}, {"<leader>w-", "Split window below"})
map({lhs = "<leader>w|", desc = "向下拆分窗口"}, {"<leader>w|", "Split window right"})
del({"<leader>-",  "Split window below"})
del({"<leader>|", "Split window right"})
-- }}}

-- tabs {{{
-- tabs
def_map("<leader><tab>", nil, 'TABS')
map({lhs = "<leader><tab>l", desc = "Last Tab" }, {"<leader><tab>l", "Last Tab" })
map({lhs = "<leader><tab>f", desc = "First Tab" }, {"<leader><tab>f", "First Tab" })
map({lhs = "<leader><tab>]", desc = "Next Tab" }, {"<leader><tab>]", "Next Tab" })
map({lhs = "<leader><tab><tab>", desc = "New Tab" }, {"<leader><tab><tab>", "New Tab"})
map({lhs = "<leader><tab>d", desc = "Close Tab" }, {"<leader><tab>d", "Close Tab" })
map({lhs = "<leader><tab>[", desc = "Previous Tab"}, {"<leader><tab>[", "Previous Tab" })
-- }}}

-- diagnostics/quickfix {{{
def_map("<leader>x", nil, 'diagnostics/quickfix')

map({lhs = "<leader>xx", desc = "文件LSP诊断(Trouble)"}, {"<leader>xx", "Document Diagnostics (Trouble)"})
map({lhs = "<leader>xX", desc = "工作区LSP诊断(Trouble)"}, {"<leader>xX", "Workspace Diagnostics (Trouble)"})
map({lhs = "<leader>xL", desc = "Location List (Trouble)"}, {"<leader>xL", "Location List (Trouble)"})
map({lhs = "<leader>xQ", desc = "Quickfix List (Trouble)"}, {"<leader>xQ", "Quickfix List (Trouble)"})
map({lhs = "<leader>xt", desc = "Todo (Trouble)"}, {"<leader>xt", "Todo (Trouble)"})
map({lhs = "<leader>xT", desc = "Todo/Fix/Fixme (Trouble)"}, {"<leader>xT", "Todo/Fix/Fixme (Trouble)"})
map({lhs = "<leader>xl", desc = "Location List" }, {"<leader>xl", "Location List"})
map({lhs = "<leader>xq", desc = "Quickfix List" }, {"<leader>xq", "Quickfix List"})

--}}}

--  导航 {{{
map({lhs = "<c-f>", desc = "Scroll forward"}, {"<c-f>", "Scroll forward", mode = { "i", "n", "s" }})
map({lhs = "<c-b>", desc = "Scroll backward"}, {"<c-b>", "Scroll backward", mode = { "i", "n", "s" }})
    -- go to  beginning and end
def_map("<C-a>", "<home>", "跳到行首", {"n", "c", "i"})
def_map("<C-e>", "<end>", "跳到行尾", {"n", "c", "i"})
def_map("<C-h>", "<Left>", "  左移", {"c", "i"})
def_map("<C-l>", "<Right>", " 右移", {"c", "i"})
def_map("<C-j>", "<Down>", " 下移", {"c", "i"})
def_map("<C-k>", "<Up>", " 上移", {"c", "i"})
def_map("<C-d>", "<del>", "del", "c")
def_map("<C-w>", "<del>", "del", "c")

def_map("<C-c>", "<cmd> %y+  <CR>", "复制整个文件")

del({"<tab>", mode = {"i", "s"}})
del({"<s-tab>", mode = {"i", "s"}})

-- better up/down
map({lhs = "j", desc = "better j"}, {"j", mode = {"n", "x"}})
map({lhs = "k", desc = "better k"}, {"k", mode = {"n", "x"}})
map({lhs = "<Down>", desc = "better j"}, {"<Down>", mode = {"n", "x"}})
map({lhs = "<Up>", desc = "better k"}, {"<Up>", mode = {"n", "x"}})

-- Move to window using the <ctrl> hjkl keys
map({lhs = "<C-h>", rhs = ":TmuxNavigateLeft <CR>", desc = " 左窗口"}, {"<C-h>", "Go to left window"})
map({lhs = "<C-j>", rhs = ":TmuxNavigateDown <CR>", desc = " 下窗口"}, {"<C-j>", "Go to lower window"})
map({lhs = "<C-k>", rhs = ":TmuxNavigateUp <CR>", desc = " 上窗口"}, {"<C-k>", "Go to upper window"})
map({lhs = "<C-l>", rhs = ":TmuxNavigateRight  <CR>", desc = " 右窗口"}, {"<C-l>", "Go to right window"})
--def_map("<C-Left>", ":TmuxNavigateLeft <CR>", "tmux  左窗口")
--def_map("<C-Right>", ":TmuxNavigateRight  <CR>", "tmux  右窗口")
--def_map("<C-Up>", ":TmuxNavigateUp <CR>", "tmux  上窗口")
--def_map("<C-Down>", ":TmuxNavigateDown <CR>", "tmux  下窗口")

-- Resize window using <ctrl> arrow keys
map({lhs = "<A-Up>", desc = "Increase window height"}, {"<C-Up>", "Increase window height"})
map({lhs = "<A-Down>", desc = "Decrease window height"}, {"<C-Down>", "Decrease window height"})
map({lhs = "<A-Left>", desc = "Decrease window width"}, {"<C-Left>", "Decrease window width"})
map({lhs = "<A-Right>", desc = "Increase window width"}, {"<C-Right>", "Increase window width"})

-- Move Lines
map({lhs = "<A-j>", desc = "向下移动行"}, {"<A-j>", "Move down", mode = {"n", "i", "v"}})
map({lhs = "<A-k>", desc = "向上移动行"},  {"<A-k>", "Move up", mode = {"n", "i", "v"}})

-- Terminal Mappings
map({lhs = "<esc><esc>", desc = "Enter Normal Mode" }, {"<esc><esc>", "Enter Normal Mode", mode = "t"})
map({lhs = "<C-h>", desc = "Go to left window"}, {"<C-h>", "Go to left window", mode = "t"})
map({lhs = "<C-j>", desc = "Go to lower window"}, {"<C-j>", "Go to lower window" , mode = "t"})
map({lhs = "<C-k>", desc = "Go to upper window"}, {"<C-k>", "Go to upper window" , mode = "t"})
map({lhs = "<C-l>", desc = "Go to right window"}, {"<C-l>", "Go to right window" , mode = "t"})
--def_map("<C-Left>", "<C-h>", "Go to left window", {remap = true, mode = {"t"}})
--def_map("<C-Down>", "<C-j>", "Go to lower window", {remap = true, mode = {"t"}})
--def_map("<C-Up>", "<C-k>", "Go to upper window", {remap = true, mode = {"t"}})
--def_map("<C-Right>", "<C-l>", "Go to right window", {remap = true, mode = {"t"}})

-- diagnostic
map({lhs = "]d", desc = "Next Diagnostic"}, { "]d", "Next Diagnostic" })
map({lhs = "[d", desc = "Prev Diagnostic"}, { "[d", "Prev Diagnostic" })
map({lhs = "]e", desc = "Next Error" },  { "]e", "Next Error" })
map({lhs = "[e", desc = "Prev Error" },  { "[e", "Prev Error" })
map({lhs = "]w", desc = "Next Warning"}, { "]w", "Next Warning" })
map({lhs = "[w", desc = "Prev Warning"}, { "[w", "Prev Warning" })

map({lhs = "]]", desc = "Next Reference"}, {"]]", "Next Reference"})
map({lhs = "[[", desc = "Prev Reference"}, {"[[", "Prev Reference"})
del({"[q", "Previous quickfix"})
del({"]q", "Next quickfix"})
map({lhs = "[q", desc = "Previous trouble/quickfix item"}, {"[q", "Previous trouble/quickfix item"})
map({lhs = "]q", desc = "Next trouble/quickfix item"}, {"]q", "Next trouble/quickfix item"})
map({lhs = "[t", desc = "Previous todo comment"}, {"[t", "Previous todo comment"})
map({lhs = "]t", desc = "Next todo comment"}, {"]t", "Next todo comment"})
map({lhs = "[b", desc = "上个 buffer"}, {"[b", "Prev buffer"})
map({lhs = "]b", desc = "下个 buffer"}, {"]b", "Next buffer"})

def_map("]h", "<cmd>Gitsigns next_hunk<CR>", "Next Hunk")
def_map("[h", "<cmd>Gitsigns prev_hunk<CR>", "Prev Hunk")
-- }}}

-- general {{{
map({lhs = "<S-Enter>", desc = "重定向Cmdline"}, {"<S-Enter>", "Redirect Cmdline", mode = "c"})
def_map("q", ":call SmartClose() <cr>", "   关闭window", {silent = true, mode = {"v", "x", "n"}})
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
def_map("p", 'p:let @+=@0<CR>:let @"=@0<CR>', "不要复制替换文本", { silent = true })
-- Clear search with <esc>
map({lhs = "<esc>", desc = "  不高亮"}, {"<esc>", "Escape and clear hlsearch", mode = {"i", "n"}})
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({lhs = "n", desc = "Next search result"}, { "n", "Next search result", mode = {"n", "x", "o"} })
map({lhs = "N", desc = "Prev search result"}, { "N", "Prev search result", mode = {"n", "x", "o"} })

-- Add undo break-points
map({lhs = ","}, {",", mode = "i"})
map({lhs = "."}, {".", mode = "i"})
map({lhs = ";"}, {";", mode = "i"})

-- save file
map({lhs = "<C-s>", desc = "﬚  保存文件"}, {"<C-s>", "Save file", mode = { "i", "x", "n", "s" }})

-- better indenting
-- 使用 < > 在可视模式下缩进
map({lhs = "<", "向左缩进"}, {"<", mode = "v"})
map({lhs = ">", desc = "向右缩进"}, {">", mode = "v"})
-- quit
map({lhs = "<leader>qq", desc = "Quit all"}, {"<leader>qq", "Quit all" })
map({lhs = "<c-space>", desc = "treesitter扩选"}, {"<c-space>", "Increment selection"})
map({lhs = "<bs>", desc = "treesitter缩选"}, {"<bs>", "Decrement selection", mode = "x"})

-- }}}

-- quit/session{{{
map({lhs = "<leader>qs", desc = "Restore Session"}, {"<leader>qs", "Restore Session"})
map({lhs = "<leader>ql", desc = "Restore Last Session"}, {"<leader>ql", "Restore Last Session"})
map({lhs = "<leader>qd", desc = "Don't Save Current Session"}, {"<leader>qd", "Don't Save Current Session"})
-- }}}

-- lsp {{{

def_map("<leader>l", nil, '  lsp')
def_map("<leader>ld", "gd", "   lsp 定义", {remap = true})
def_map("<leader>lD", "gD", "   lsp 声明", {remap = true})
def_map("<leader>ly", "gy", "   lsp 类型定义", {remap = true})
def_map("<leader>lr", "gr", "   lsp 调用", {remap = true})
def_map("<leader>lI", "gI", "   lsp 实现", {remap = true})
def_map("<leader>lk", "K", "   lsp 悬停提示", {remap = true})
def_map("<leader>lK", "gK", "   lsp 签名帮助", {remap = true})
def_map("<leader>lR", "<leader>cr", "   lsp 重命名", {remap = true})
def_map("<leader>la", "<leader>ca", "   lsp 代码执行", {remap = true})
--
-- }}}

-- 按键记录{{{
-- echasnovski/mini.surround
-- 选中后 gsa" 添加引号
-- gsd" 删除引号
-- gsr"' 替换"为'
-- gsh{ 高亮下 {}
-- Telescope:
-- <C-f> 预览下翻页
-- <C-b> 预览上翻页
-- <c-h> 预览左移
-- <c-l> 预览右移
-- <m-h> 选择左移
-- <m-l> 选择右移
--
-- <c-t> 发送到trouble
-- <a-t> 发送选择的到trouble
-- <tab> 选择
-- <s-tab> 取消选择
-- <c-e> 切换预览显示
--
-- <a-i> 查找文件(带忽略)
-- <a-i> 查找文件(带隐藏)
--
-- <c-up> 上个历史
-- <c-Down> 下个历史
--
--
-- <A-j> 移动到下一行
-- <A-k> 移动到上一行
--
-- s 跳转
-- f F t T 跳转
-- S 语法树选择
--
-- <leader>sr 正则搜索替换
-- <c-space> treesitter扩选
-- <bs> treesitter缩选
--
-- <leader>we 文件树和标签自动弹出
-- <leader><space> 查找当前符号
--
-- <c-/> 终端
-- <c-p> 搜索文件
-- alingn
-- s 对齐符号
-- j 对齐方向
-- m 替换添加的空格
-- f 哪些要对齐(n==1 n==3)
-- p 对齐符号紧邻前一个字符
-- t 修剪空白
-- <BS> 删除最后的前置步骤
--
-- 多行编辑
-- <c-n> 选择
-- S-Right/S-Left开始选择向右或向左
-- [ 上一下
-- ] 下一个
-- q 跳过这一个
-- Q 取消当前
-- \\\ 添加光标
-- }}}
