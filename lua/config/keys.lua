local map = require("utils.replace_keys").add_replace_keys
local del = require("utils.replace_keys").del_keymap
local def_map = require("utils.replace_keys").def_map
vim.cmd('source ' .. vim.fn.stdpath("config") .. '/lua/config/edit.vim')
-- "echasnovski/mini.surround"


def_map("<leader>j", nil, '+ﭠ  跳转')

    -- go to  beginning and end
def_map("<C-a>", "<home>", "跳到行首", {"n", "c", "i"})
def_map("<C-e>", "<end>", "跳到行尾", {"n", "c", "i"})
def_map("<C-h>", "<Left>", "  左移", {"c", "i"})
def_map("<C-l>", "<Right>", " 右移", {"c", "i"})
def_map("<C-j>", "<Down>", " 下移", {"c", "i"})
def_map("<C-k>", "<Up>", " 上移", {"c", "i"})
def_map("<C-d>", "<del>", "del", "c")
def_map("<C-w>", "<del>", "del", "c")

def_map("<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "   退出终端模式"}, "t")

    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
def_map("p", 'p:let @+=@0<CR>:let @"=@0<CR>', "不要复制替换文本", { silent = true })
def_map("<leader>ts", "<cmd>Translate ZH -output=floating  <CR>", "翻译选择文本", "v")

-- 搜索/符号 {{{
def_map("<leader>ss", "<cmd>Telescope grep_string <CR>", "查找当前符号", "v")
-- }}}

-- 文本/编辑 {{{
def_map("<leader>xa", "<cmd>EasyAlign <CR>", "  文本对齐", "v")
-- }}}
--
-- general {{{
def_map("<C-left>", ":TmuxNavigateLeft <CR>", "tmux  左窗口")
def_map("<c-right>", ":TmuxNavigateRight  <CR>", "tmux  右窗口")
def_map("<C-up>", ":TmuxNavigateUp <CR>", "tmux  上窗口")
def_map("<c-down>", ":TmuxNavigateDown <CR>", "tmux  下窗口")
def_map("<C-c>", "<cmd> %y+  <CR>", "复制整个文件")
def_map("<leader>ck", ":WhichKey <CR>", "WhichKey 查找映射")
--}}}

-- 新建 {{{
-- }}}

-- 窗口 {{{
def_map('<leader>wp', "<cmd>WinShift <CR>", "重新排列窗口")
def_map("<leader>ww", "<cmd>ChooseWin <CR>", "选择窗口")
def_map("<leader>wm", "<cmd>ChooseWinSwap  <CR>", "交换窗口")
-- }}}

-- 切换 {{{
map({lhs = "<leader>cs", desc = "标签浏览"}, {"<leader>cs", "Symbols Outline"})
map({lhs = "<leader>cp", desc = "markdown预览"}, {"<leader>cp", "Markdown Preview"})
def_map("<leader>tnd", ":e ++ff=unix <CR>", '显示dos换行')
def_map("<leader>tnu", ":e ++ff=dos <CR>", '显示unix换行')
def_map("<leader>thh", ":set cursorline! <CR>", '切换行高亮')
def_map("<leader>thc", ":set cursorcolumn! <CR>", '切换列高亮')
def_map("<leader>tl", ":set list! <CR>", '切换隐藏的字符')
def_map("<leader>tc", ":call ToggleMouseCopy() <CR>",  '切换鼠标粘贴')
-- }}}

-- 注释 {{{
def_map("<leader>/", "gc", "  注释", {remap = true, mode = {"n", "x"}})
def_map("<leader>/c", "gc", "切换行注释", {remap = true, mode = {"n", "x"}})
def_map("<leader>/b", "gb", "切换块注释", {remap = true, mode = {"n", "x"}})
def_map("<leader>/f", ":Dox <CR>", "生成函数注释")
def_map("<leader>/l", ":DoxLic <CR>", "生成许可证注释")
def_map("<leader>/a", ":DoxAuthor <CR>", "生成作者注释")
--- }}}
-- git {{{
def_map("<leader>ghB", "<cmd>Gitsigns toggle_current_line_blame <CR>", "当前行 blame")
-- }}}

-- buffer {{{

def_map("<leader>b<TAB>", "<cmd>BufferLineMoveNext <CR>", "移动buf到下一个")
def_map("<leader>b<S-Tab>", "<cmd>BufferLineMovePrev <CR>", "移动buf到上一个")
--- }}}

    -- 文件/查找 {{{
def_map("<leader>fF", ":lua vim.cmd('Telescope find_files find_command=fdfind,--type,f,-p,' .. vim.fn.expand('<cfile>'))  <CR>", "查找光标下文件")
def_map("<leader>fg", "<cmd>Telescope git_files  <CR>", "查找文件(git范围)")
def_map("<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true  <CR>", "查找所有文件")
def_map("<leader>ft", "<cmd>Telescope terms <CR>", "   查找 term")

-- 文件
def_map("<leader>fw", ":SudaWrite  <CR>", "以sudo保存文件")
def_map("<leader>fr", ":SudaRead  <CR>", "以sudo读取文件")
def_map("<leader>fe", "<cmd>Neotree filesystem focus <CR>", "跳转到文件树")
-- }}}

-- 搜索/符号 {{{
def_map("<leader>sa", "<cmd>Telescope <CR>", "Telescope")
def_map("<leader>sq", "<cmd>Telescope quickfix <CR>", "quickfix查找")
def_map("<leader>sm", ":lua require'marks'.mark_state:all_to_list('quickfixlist') vim.cmd('Telescope quickfix') <CR>", "查找mark")
-- }}}

-- tag/标签 {{{
def_map("<leader>mma", ":lua require'marks'.set_next() <CR>", "添加标签")
def_map("<leader>mmd", ":lua require'marks'.delete_line() <CR>", "当前标签")
def_map("<leader>mmD", ":lua require'marks'.delete_buf() <CR>", "删除所有标签")
def_map("<leader>mmn", ":lua require'marks'.next() <CR>", "上一个标签")
def_map("<leader>mmp", ":lua require'marks'.prev() <CR>", "下一个标签")
def_map("<leader>mt", ":GscopeSwitchLayout <CR>", "切换 scope layout")
def_map("<leader>ms", ":GscopeFind s <C-R><C-W> <CR>", "查找符号")
def_map("<leader>mg", ":GscopeFind g <C-R><C-W> <CR>", "查找定义")
def_map("<c-]>", ":Telescope lsp_handlers target=definitions <CR>", "查找定义")
def_map("<leader>mr", ":GscopeFind c <C-R><C-W> <CR>", "查找引用")
def_map("<leader>mf", ":GscopeFind f <C-R>=expand('<cfile>')<cr><cr>", "查找文件")
def_map("<leader>ma", ":GscopeFind a <C-R><C-W> <CR>", "查找赋值")
-- }}}

-- 跳转 {{{
def_map("<leader>jj", function ()
    require("flash").jump({
        search = { forward = true, wrap = true, multi_window = false },
    })
end, "按一个字符跳")
def_map("<leader>jp", "/", "按Pattern跳", {remap = true})
-- }}}

-- lsp {{{

--def_map("gD", ":Telescope lsp_handlers target=declaration <CR>", "   lsp 声明")
--def_map("gd", ":Telescope lsp_handlers target=definitions <CR>", "   lsp 定义")
--def_map("K", ":lua vim.lsp.buf.hover() <CR>", "   lsp 悬停提示")
--def_map("gi", ":Telescope lsp_handlers target=implementations <CR>", "   lsp 实现")
--
--def_map("<leader>ld", ":Telescope lsp_handlers target=definitions <CR>", "   lsp 定义")
--def_map("<leader>lD", ":Telescope lsp_handlers target=type_definitions <CR>", "   lsp 类型定义")
--def_map("<leader>lr", ":Telescope lsp_handlers target=references <CR>", "   lsp 调用")
--def_map("<leader>li", ":Telescope lsp_handlers target=declaration <CR>", "   lsp 声明")
--def_map("<leader>lI", ":Telescope lsp_handlers target=implementations <CR>", "   lsp 实现")
--def_map("<leader>lk", ":lua vim.lsp.buf.hoignature_helper() <CR>", "   lsp 悬停提示")
--def_map("<leader>ls", ":lua vim.lsp.buf.signature_help() <CR>", "   lsp 签名帮助")
--def_map("<leader>lR", ":lua require('ui.renamer').open() <CR>", "   lsp 重命名")
--def_map("<leader>la", ":lua vim.lsp.buf.code_action() <CR>", "   lsp 代码执行")
--
--def_map("<leader>llf", ":lua vim.diagnostic.open_float() <CR>", "   lsp 诊断")
--def_map("<leader>lln", ":lua vim.diagnostic.goto_prev() <CR>", "   lsp 下一个诊断")
--def_map("<leader>llp", ":lua vim.diagnostic.goto_next() <CR>", "   lsp 上一个诊断")
--def_map("<leader>lll", ":lua vim.diagnostic.setloclist() <CR>", "   lsp 诊断列表")
--def_map("<leader>lf", ":lua vim.lsp.buf.formatting() <CR>", "   lsp 格式化")
--
--def_map("<leader>lwa", ":lua vim.lsp.buf.add_workspace_folder() <CR>", "   添加工作区")
--def_map("<leader>lwr", ":lua vim.lsp.buf.remove_workspace_folder() <CR>", "   移除工作区")
--def_map("<leader>lwl", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) <CR>", "   显示工作区")
-- }}}

-- 文本/编辑 {{{
def_map("<leader>xd ", ":lua vim.fn.Delete_extra_space() <CR>", "删除光标周围的额外空格")
def_map("<leader>xdw", ":StripWhitespace <CR>", "删除行尾空格")
def_map("<leader>xic", ":CamelB <CR>", "转换为小驼峰法")
def_map("<leader>xiC", ":CamelB <CR>", "转换为大驼峰法")
def_map("<leader>xi-", ":Kebab <CR>", "转换为中划线(-)法")
def_map("<leader>xi_", ":Snek <CR>", "转换为下划线(_)法")
def_map("<leader>xiU", ":Screm <CR>", "转换为宏定义")
def_map("<leader>xtt", ":lua vim.fn.Spa2Tab() <CR>", "空格转Tab")
def_map("<leader>xt ", ":lua vim.fn.Tab2Spa() <CR>", "Tab转空格")

def_map("<leader>xrc", ":call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>", "询问替换")
def_map("<leader>xrw", ":call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>", "直接替换")
def_map("<leader>xRc", ":call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>", "询问替换")
def_map("<leader>xRw", ":call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>", "直接替换")

def_map("<leader>xu", ":UndotreeToggle <CR>", "撤销树")
def_map("<leader>xy", ":call copy2system() <CR>", "复制到系统")
def_map("<leader>xp", ":call paste2system() <CR>", "从系统粘贴")

--}}}

--map({lhs = "<tab>"}, {"<tab>", mode = "i"})
--map({lhs = "<tab>"}, {"<tab>", mode = "s"})
--map({lhs = "<s-tab>"}, {"<s-tab>", mode = {"i", "s"}})
del({"<tab>", mode = {"i", "s"}})
del({"<s-tab>", mode = {"i", "s"}})

--- {{{ mini default keymap

-- better up/down
map({lhs = "j", desc = "better j"}, {"j", mode = {"n", "x"}})
map({lhs = "k", desc = "better k"}, {"k", mode = {"n", "x"}})
map({lhs = "<Down>", desc = "better j"}, {"<Down>", mode = {"n", "x"}})
map({lhs = "<Up>", desc = "better k"}, {"<Up>", mode = {"n", "x"}})

-- Move to window using the <ctrl> hjkl keys
map({lhs = "<C-h>", desc = " 左窗口"}, {"<C-h>", "Go to left window"})
map({lhs = "<C-j>", desc = " 下窗口"}, {"<C-j>", "Go to lower window"})
map({lhs = "<C-k>", desc = " 上窗口"}, {"<C-k>", "Go to upper window"})
map({lhs = "<C-l>", desc = " 右窗口"}, {"<C-l>", "Go to right window"})

-- Resize window using <ctrl> arrow keys
map({lhs = "<C-Up>", desc = "Increase window height"}, {"<C-Up>", "Increase window height"})
map({lhs = "<C-Down>", desc = "Decrease window height"}, {"<C-Down>", "Decrease window height"})
map({lhs = "<C-Left>", desc = "Decrease window width"}, {"<C-Left>", "Decrease window width"})
map({lhs = "<C-Right>", desc = "Increase window width"}, {"<C-Right>", "Increase window width"})

-- Move Lines
map({lhs = "<A-j>", desc = "向下移动行"}, {"<A-j>", "Move down", mode = {"n", "i", "v"}})
map({lhs = "<A-k>", desc = "向上移动行"},  {"<A-k>", "Move up", mode = {"n", "i", "v"}})

-- buffers
--map({lhs = "<S-h>", desc = "Prev buffer" }, {"<S-h>", "Prev buffer" })
--map({lhs = "<S-l>", desc = "Next buffer" }, {"<S-l>", "Next buffer" })
--map({lhs = "[b", desc = "Prev buffer" }, {"[b", "Prev buffer" })
--map({lhs = "]b", desc = "Next buffer" }, {"]b", "Next buffer" })
map({lhs = "<leader>bb", desc = "Switch to Other Buffer" }, {"<leader>bb", "Switch to Other Buffer" })
map({lhs = "<leader>`", desc = "Switch to Other Buffer" }, {"<leader>`", "Switch to Other Buffer" })

-- Clear search with <esc>
map({lhs = "<esc>", desc = "  不高亮"}, {"<esc>", "Escape and clear hlsearch", mode = {"i", "n"}})

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map({lhs = "<leader>ur", desc = "Redraw / clear hlsearch / diff update"}, {"<leader>ur", "Redraw / clear hlsearch / diff update"})

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({lhs = "n", desc = "Next search result"}, { "n", "Next search result", mode = {"n", "x", "o"} })
map({lhs = "N", desc = "Prev search result"}, { "N", "Prev search result", mode = {"n", "x", "o"} })

-- Add undo break-points
map({lhs = ","}, {",", mode = "i"})
map({lhs = "."}, {".", mode = "i"})
map({lhs = ";"}, {";", mode = "i"})

-- save file
map({lhs = "<C-s>", desc = "﬚  保存文件"}, {"<C-s>", "Save file", mode = { "i", "x", "n", "s" }})

--keywordprg
map({lhs = "<leader>K", desc = "Keywordprg" }, {"<leader>K", "Keywordprg"})

-- better indenting
-- 使用 < > 在可视模式下缩进
map({lhs = "<", "向左缩进"}, {"<", mode = "v"})
map({lhs = ">", desc = "向右缩进"}, {">", mode = "v"})

-- lazy
map({lhs = "<leader>l", desc = "  插件" }, {"<leader>l", "Lazy"})

-- new file
map({lhs = "<leader>fn", desc = "烙 新建 buffer" }, {"<leader>fn", "New File"})

map({lhs = "<leader>xl", desc = "Location List" }, {"<leader>xl", "Location List"})
map({lhs = "<leader>xq", desc = "Quickfix List" }, {"<leader>xq", "Quickfix List"})

-- map({lhs = "[q", desc = "Previous quickfix"}, {"[q", "Previous quickfix" })
-- map({lhs = "]q", desc = "Next quickfix"}, {"]q", "Next quickfix" })
del({"[q", "Previous quickfix"})
del({"]q", "Next quickfix"})

-- formatting
map({lhs = "<leader>cf", desc = "Format"}, {"<leader>cf", "Format", mode = { "n", "v" }})

-- diagnostic
map({lhs = "<leader>cd", desc = "Line Diagnostics" }, {"<leader>cd", "Line Diagnostics"})
map({lhs = "]d", desc = "Next Diagnostic"}, { "]d", "Next Diagnostic" })
map({lhs = "[d", desc = "Prev Diagnostic"}, { "[d", "Prev Diagnostic" })
map({lhs = "]e", desc = "Next Error" },  { "]e", "Next Error" })
map({lhs = "[e", desc = "Prev Error" },  { "[e", "Prev Error" })
map({lhs = "]w", desc = "Next Warning"}, { "]w", "Next Warning" })
map({lhs = "[w", desc = "Prev Warning"}, { "[w", "Prev Warning" })

-- stylua: ignore start

-- toggle options
map({lhs = "<leader>uf", desc = "Toggle auto format (global)"}, {  "<leader>uf", "Toggle auto format (global)" })
map({lhs = "<leader>uF", desc = "Toggle auto format (buffer)"}, {  "<leader>uF", "Toggle auto format (buffer)" })
map({lhs = "<leader>us", desc = "Toggle Spelling" }, { "<leader>us", "Toggle Spelling" })
map({lhs = "<leader>uw", desc = "Toggle Word Wrap" }, { "<leader>uw", "Toggle Word Wrap" })
map({lhs = "<leader>uL", desc = "切换相对行号"}, { "<leader>uL", "Toggle Relative Line Numbers" })
map({lhs = "<leader>ul", desc = "关闭/显示行号" }, { "<leader>ul", "Toggle Line Numbers" })
map({lhs = "<leader>ud", desc = "Toggle Diagnostics" }, { "<leader>ud", "Toggle Diagnostics" })
map({lhs = "<leader>uc", desc = "Toggle Conceal" }, { "<leader>uc", "Toggle Conceal" })
if vim.lsp.inlay_hint then
map({lhs = "<leader>uh", desc = "Toggle Inlay Hints" }, { "<leader>uh", "Toggle Inlay Hints" })
end
map({lhs = "<leader>uT", desc = "Toggle Treesitter Highlight"}, { "<leader>uT", "Toggle Treesitter Highlight" })

-- lazygit
map({lhs = "<leader>gg", desc = "Lazygit (root dir)"}, { "<leader>gg", "Lazygit (root dir)" })
map({lhs = "<leader>gG", desc = "Lazygit (cwd)" }, { "<leader>gG", "Lazygit (cwd)" })

-- quit
map({lhs = "<leader>qq", desc = "Quit all"}, {"<leader>qq", "Quit all" })

-- highlights under cursor
map({lhs = "<leader>ui", desc = "Inspect Pos"}, { "<leader>ui", "Inspect Pos" })

-- LazyVim Changelog
map({lhs = "<leader>L", "LazyVim Changelog"}, { "<leader>L", "LazyVim Changelog" })

-- floating terminal
map({lhs = "<leader>ft", desc = "  新终端(root dir)"}, { "<leader>ft", "Terminal (root dir)" })
map({lhs = "<leader>fT", desc = "  新终端(cwd)" }, { "<leader>fT", "Terminal (cwd)" })
map({lhs = "<c-/>", desc = "  新终端(root dir)"}, {"<c-/>", "Terminal (root dir)" })
map({lhs = "<c-_>", desc = "  新终端(root dir)" }, { "<c-_>", "which_key_ignore" })

-- Terminal Mappings
map({lhs = "<esc><esc>", desc = "Enter Normal Mode" }, {"<esc><esc>", "Enter Normal Mode", mode = "t"})
map({lhs = "<C-h>", desc = "Go to left window"}, {"<C-h>", "Go to left window", mode = "t"})
map({lhs = "<C-j>", desc = "Go to lower window"}, {"<C-j>", "Go to lower window" , mode = "t"})
map({lhs = "<C-k>", desc = "Go to upper window"}, {"<C-k>", "Go to upper window" , mode = "t"})
map({lhs = "<C-l>", desc = "Go to right window"}, {"<C-l>", "Go to right window" , mode = "t"})
map({lhs = "<C-/>", desc = "Hide Terminal" }, {"<C-/>", "Hide Terminal" , mode = "t"})
map({lhs = "<c-_>", desc = "which_key_ignore" }, {"<c-_>", "which_key_ignore" , mode = "t"})

-- windows
map({lhs = "<leader>ww", desc = "Other window"}, {"<leader>ww", "Other window"})
map({lhs = "<leader>wd", desc = "删除窗口"}, {"<leader>wd", "Delete window"})
map({lhs = "<leader>w-", desc = "Split window below"}, {"<leader>w-", "Split window below"})
map({lhs = "<leader>w|", desc = "Split window right"}, {"<leader>w|", "Split window right"})
map({lhs = "<leader>-", desc = "Split window below"}, {"<leader>-",  "Split window below"})
map({lhs = "<leader>|", desc = "Split window right"}, {"<leader>|", "Split window right"})

-- tabs
map({lhs = "<leader><tab>l", desc = "Last Tab" }, {"<leader><tab>l", "Last Tab" })
map({lhs = "<leader><tab>f", desc = "First Tab" }, {"<leader><tab>f", "First Tab" })
map({lhs = "<leader><tab>]", desc = "Next Tab" }, {"<leader><tab>]", "Next Tab" })
map({lhs = "<leader><tab><tab>", desc = "New Tab" }, {"<leader><tab><tab>", "New Tab"})
map({lhs = "<leader><tab>d", desc = "Close Tab" }, {"<leader><tab>d", "Close Tab" })
map({lhs = "<leader><tab>[", desc = "Previous Tab"}, {"<leader><tab>[", "Previous Tab" })

--- }}}

--- {{{ plugins keymap

--map({desc = "切换自动成对字符"}, {"<leader>up", "Toggle auto pairs"})
map({lhs = "<leader>cF", desc = "格式化(嵌入代码块)"}, {"<leader>cF", "Format Injected Langs", mode = { "n", "v" }})
map({lhs = "<leader>cm", desc = "  LSP/DAP 服务器"}, {"<leader>cm", "Mason"})
map({lhs = "<c-space>", desc = "Increment selection"}, {"<c-space>", "Increment selection"})
map({lhs = "<bs>", desc = "Decrement selection"}, {"<bs>", "Decrement selection", mode = "x"})
map({lhs = "<leader>ut", desc = "Toggle Treesitter Context"}, {"<leader>ut", "Toggle Treesitter Context"})
map({lhs = "<leader>un", desc = "Dismiss all Notifications"}, {"<leader>un","Dismiss all Notifications"})
map({lhs = "<leader>bp", desc = "Toggle pin"}, {"<leader>bp", "Toggle pin"})
map({lhs = "<leader>bP", desc = "Delete non-pinned buffers"}, {"<leader>bP", "Delete non-pinned buffers"})
map({lhs = "<leader>bo", desc = "Delete other buffers"}, {"<leader>bo", "Delete other buffers"})
map({lhs = "<leader>br", desc = "Delete buffers to the right"}, {"<leader>br", "Delete buffers to the right"})
map({lhs = "<leader>bl", desc = "Delete buffers to the left"}, {"<leader>bl", "Delete buffers to the left"})
map({lhs = "<leader>up", desc = "Toggle auto pairs"}, {"<leader>up", "Toggle auto pairs"})
map({lhs = "<leader>fl", desc = "文件树(root dir)"}, {"<leader>fe", "Explorer NeoTree (root dir)"})
map({lhs = "<leader>fL", desc = "文件树(cwd)"}, {"<leader>fE", "Explorer NeoTree (cwd)"})
map({lhs = "<leader>e", desc = "文件树(root dir)", rhs = "<leader>fl"}, {"<leader>e", "Explorer NeoTree (root dir)"})
map({lhs = "<leader>E", desc = "文件树(cwd)", rhs = "<leader>fL"}, {"<leader>E", "Explorer NeoTree (cwd)"})
map({lhs = "<leader>ge", desc = "Git explorer"}, {"<leader>ge", "Git explorer"})
map({lhs = "<leader>be", desc = "Buffer explorer"}, {"<leader>be", "Buffer explorer"})
map({lhs = "<leader>sr", desc = "Replace in files (Spectre)"}, {"<leader>sr", "Replace in files (Spectre)"})
map({lhs = "<leader>,", desc = "Switch Buffer"}, {"<leader>,", "Switch Buffer"})
map({lhs = "<leader>/", desc = "Grep (root dir)"}, {"<leader>/", "Grep (root dir)"})
map({lhs = "<leader>:", desc = "Command History"}, {"<leader>:", "Command History"})
map({lhs = "<leader><space>", desc = "查找文件(root dir)"}, {"<leader><space>", "Find Files (root dir)"})
-- find
map({ lhs = "<leader>fb", desc = "buf 浏览器" }, { "<leader>fb", "Buffers" })
map({ lhs = "<leader>fc", desc = "Find Config File" }, { "<leader>fc", "Find Config File" })
map({ lhs = "<leader>ff", desc = "查找文件(root dir)" }, { "<leader>ff", "Find Files (root dir)" })
map({ lhs = "<leader>fF", desc = "查找文件(cwd)" }, { "<leader>fF", "Find Files (cwd)" })
map({ lhs = "<leader>fr", desc = "查找近期文件" }, { "<leader>fr", "Recent" })
map({ lhs = "<leader>fR", desc = "查找近期文件(cwd)" }, { "<leader>fR", "Recent (cwd)" })
-- git
map({ lhs = "<leader>gc", desc = "commits" }, { "<leader>gc", "commits" })
map({ lhs = "<leader>gs", desc = "status" }, { "<leader>gs", "status" })
-- search
map({ lhs = '<leader>s"', desc = "Registers" }, { '<leader>s"', "Registers" })
map({ lhs = "<leader>sa", desc = "Auto Commands" }, { "<leader>sa", "Auto Commands" })
map({ lhs = "<leader>sb", desc = "Buffer" }, { "<leader>sb", "Buffer" })
map({ lhs = "<leader>sc", desc = "Command History" }, { "<leader>sc", "Command History" })
map({ lhs = "<leader>sC", desc = "Commands" }, { "<leader>sC", "Commands" })
map({ lhs = "<leader>sd", desc = "Document diagnostics" }, { "<leader>sd", "Document diagnostics" })
map({ lhs = "<leader>sD", desc = "Workspace diagnostics" }, { "<leader>sD", "Workspace diagnostics" })
map({ lhs = "<leader>sg", desc = "实时查找(root dir)" }, { "<leader>sg", "Grep (root dir)" })
map({ lhs = "<leader>sG", desc = "实时查找(cwd)" }, { "<leader>sG", "Grep (cwd)" })
map({ lhs = "<leader>sh", desc = "Help Pages" }, { "<leader>sh", "Help Pages" })
map({ lhs = "<leader>sH", desc = "Search Highlight Groups" }, { "<leader>sH", "Search Highlight Groups" })
map({ lhs = "<leader>sk", desc = "查找keymap" }, { "<leader>sk", "Key Maps" })
map({ lhs = "<leader>sM", desc = "Man Pages" }, { "<leader>sM", "Man Pages" })
map({ lhs = "<leader>sm", desc = "查找mark" }, { "<leader>sm", "Jump to Mark" })
map({ lhs = "<leader>so", desc = "Options" }, { "<leader>so", "Options" })
map({ lhs = "<leader>sR", desc = "Resume" }, { "<leader>sR", "Resume" })
map({ lhs = "<leader>sw", desc = "查找当前符号(root dir)" }, { "<leader>sw", "Word (root dir)" })
map({ lhs = "<leader>sW", desc = "查找当前符号(cwd)" }, { "<leader>sW", "Word (cwd)" })
map({ lhs = "<leader>sw", desc = "查找字符串(root dir)" }, { "<leader>sw", "Selection (root dir)", mode = "v" })
map({ lhs = "<leader>sW", desc = "查找字符串(cwd)" }, { "<leader>sW", "Selection (cwd)", mode = "v" })
map({ lhs = "<leader>uC", desc = "   查找主题和预览" }, { "<leader>uC", "Colorscheme with preview" })
map({ lhs = "<leader>ss", desc = "Goto Symbol" }, { "<leader>ss", "Goto Symbol" })
map({ lhs = "<leader>sS", desc = "Goto Symbol (Workspace)" }, { "<leader>sS", "Goto Symbol (Workspace)" })
map({lhs = "s", desc = "按字符跳"}, {"s", "Flash", mode = { "n", "x", "o" }})
map({lhs = "S", desc = "按Treesitter跳"}, {"S", "Flash Treesitter", mode = { "n", "x", "o" }})
map({lhs = "r", desc = "Remote Operator"}, {"r", "Remote Flash", mode = "o"})
map({lhs = "R", desc = "Remote Treesitter Operator"}, {"R", "Treesitter Search", mode = { "o", "x" }})
map({lhs = "<c-s>", desc = "切换Flash搜索"}, {"<c-s>", "Toggle Flash Search", mode = "c" })
map({lhs = "]]", desc = "Next Reference"}, {"]]", "Next Reference"})
map({lhs = "[[", desc = "Prev Reference"}, {"[[", "Prev Reference"})
map({lhs = "<leader>bd", desc = "   关闭window"}, {"<leader>bd", "Delete Buffer"})
--def_map("q", "<leader>bd", "   关闭window", {remap = true})
def_map("q", ":call SmartClose() <cr>", "   关闭window", {silent = true})
map({lhs = "<leader>bD", desc = "   关闭window(Force)"}, {"<leader>bD", "Delete Buffer (Force)"})
map({lhs = "<leader>xx", desc = "Document Diagnostics (Trouble)"}, {"<leader>xx", "Document Diagnostics (Trouble)"})
map({lhs = "<leader>xX", desc = "Workspace Diagnostics (Trouble)"}, {"<leader>xX", "Workspace Diagnostics (Trouble)"})
map({lhs = "<leader>xL", desc = "Location List (Trouble)"}, {"<leader>xL", "Location List (Trouble)"})
map({lhs = "<leader>xQ", desc = "Quickfix List (Trouble)"}, {"<leader>xQ", "Quickfix List (Trouble)"})
map({lhs = "[q", desc = "Previous trouble/quickfix item"}, {"[q", "Previous trouble/quickfix item"})
map({lhs = "]q", desc = "Next trouble/quickfix item"}, {"]q", "Next trouble/quickfix item"})
map({lhs = "[t", desc = "Previous todo comment"}, {"[t", "Previous todo comment"})
map({lhs = "]t", desc = "Next todo comment"}, {"]t", "Next todo comment"})
map({lhs = "<leader>xt", desc = "Todo (Trouble)"}, {"<leader>xt", "Todo (Trouble)"})
map({lhs = "<leader>xT", desc = "Todo/Fix/Fixme (Trouble)"}, {"<leader>xT", "Todo/Fix/Fixme (Trouble)"})
map({lhs = "<leader>st", desc = "Todo"}, {"<leader>st", "Todo"})
map({lhs = "<leader>sT", desc = "Todo/Fix/Fixme"}, {"<leader>sT", "Todo/Fix/Fixme"})
     -- cycle through buffers
map({lhs = "<S-TAB>", desc = "  上个 buffer"}, {"<S-h>", "Prev buffer"})
map({lhs = "<TAB>", desc = "  下个 buffer"}, {"<S-l>", "Next buffer"})
map({lhs = "[b", desc = "Prev buffer"}, {"[b", "Prev buffer"})
map({lhs = "]b", desc = "Next buffer"}, {"]b", "Next buffer"})
map({lhs = "<S-Enter>", desc = "Redirect Cmdline"}, {"<S-Enter>", "Redirect Cmdline", mode = "c"})
map({lhs = "<leader>snl", desc = "Noice Last Message"}, {"<leader>snl", "Noice Last Message"})
map({lhs = "<leader>snh", desc = "Noice History"}, {"<leader>snh", "Noice History"})
map({lhs = "<leader>sna", desc = "Noice All"}, {"<leader>sna", "Noice All"})
map({lhs = "<leader>snd", desc = "Dismiss All"}, {"<leader>snd", "Dismiss All"})
map({lhs = "<c-f>", desc = "Scroll forward"}, {"<c-f>", "Scroll forward", mode = { "i", "n", "s" }})
map({lhs = "<c-b>", desc = "Scroll backward"}, {"<c-b>", "Scroll backward", mode = { "i", "n", "s" }})
map({lhs = "<leader>qs", desc = "Restore Session"}, {"<leader>qs", "Restore Session"})
map({lhs = "<leader>ql", desc = "Restore Last Session"}, {"<leader>ql", "Restore Last Session"})
map({lhs = "<leader>qd", desc = "Don't Save Current Session"}, {"<leader>qd", "Don't Save Current Session"})

map({lhs = "<leader>uE", desc = "Edgy Select Window"}, {"<leader>uE", "Edgy Select Window"})
map({lhs = "<leader>ue", desc = "Edgy Toggle"}, {"<leader>ue", "Edgy Toggle"})

--- }}}
