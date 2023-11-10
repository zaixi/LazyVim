-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

require("utils")
--if true then
--  return {}
--end

local opt = vim.opt

vim.g.autoformat = false
vim.g.mapleader = " "
------------------------------------------------------------
-- 基础设置
------------------------------------------------------------
opt.conceallevel = 0 -- ``在markdown文件中是可见的
opt.splitbelow = true -- 强制所有水平拆分到当前窗口下方
opt.splitright = true -- 强制所有垂直拆分到当前窗口右侧
opt.undofile = true -- 持久撤消
opt.clipboard = "unnamedplus" -- 允许neovim访问系统剪贴板
opt.backup = false -- 创建备份文件
opt.writebackup = false -- 保存时不备份
opt.swapfile = false -- 禁用交换文件
opt.cmdheight = 2 -- neovim命令行中有更多空间用于显示消息
opt.updatetime = 300 -- 更快完成,默认为4000毫秒,更新时间较长会导致明显的延迟和糟糕的用户体验
opt.shortmess = "c" -- 不要将消息传递到| ins完成菜单|。
opt.ttimeout = true -- 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
opt.ttimeoutlen = 100 -- 功能键超时检测(毫秒)
opt.timeoutlen = 400

opt.winaltkeys = "no" -- Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
opt.wrap = false -- 关闭长行自动折行
opt.hidden = true -- 允许在有未保存的修改时切换缓冲区
opt.iskeyword = "_,@,%,#" -- 以下字符被视为单词的一部分

opt.ruler = true -- 显示光标位置
opt.laststatus = 3 -- 全局状态栏
opt.showtabline = 2 -- 总是显示标签栏
opt.signcolumn = "yes" -- 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
opt.number = true -- 显示行号
opt.relativenumber = false -- 设置相对行号
opt.numberwidth = 2 -- 将行号列宽设置为2{default 4}
opt.cursorcolumn = true -- 高亮光标所在列
opt.cursorline = true -- 高亮光标所在行
opt.scrolloff = 8 -- 光标移动到顶部和底部时保持几行距离
opt.sidescrolloff = 8 -- 光标左右两侧保留的最少屏幕列数

------------------------------------------------------------
-- 搜索设置
------------------------------------------------------------
opt.ignorecase = true -- 搜索时忽略大小写
opt.smartcase = true -- 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
opt.hlsearch = true -- 高亮搜索内容
opt.incsearch = true -- 查找输入时动态增量显示查找结果

------------------------------------------------------------
-- 编码设置
------------------------------------------------------------
opt.langmenu = "zh_CN.UTF-8" -- 菜单翻译的语言
opt.helplang = "cn" -- 消息语言为中文
opt.encoding = "utf-8" -- 文件默认编码
opt.fileencoding = "utf-8" -- 写入文件使用的编码
opt.fileencodings = "ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1" -- 打开文件时自动尝试下面顺序的编码

------------------------------------------------------------------------
-- 其他设置
------------------------------------------------------------------------
opt.mouse = "" -- 允许在neovim中使用鼠标
opt.showmatch = true -- 显示匹配的括号
opt.matchtime = 1 -- 显示括号匹配的时间
opt.wildmenu = true -- 命令行菜单补全
-- lazyredraw = true    -- 延迟绘制（提升性能）
opt.formatoptions = "mB" -- 如遇Unicode值大于255的文本,不必等到空格再折行,合并两行中文时,不在中间加空格
opt.pumheight = 15 -- 自动补全菜单的高度
opt.title = true -- 窗口标题会被设为 'titlestring' 的值
opt.termguicolors = true -- 在终端上使用 highlight-guifg 和 highlight-guibg 属性
opt.completeopt = { "menuone", "noselect" } -- 主要是为了cmp
opt.diffopt = "internal,algorithm:patience" -- 更好的 Diff 选项
-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

------------------------------------------------------------
-- 缩进和折叠(可以后期覆盖)
------------------------------------------------------------
-- 行首的 <Tab>: 长度是 'shiftwidth'(smarttab on) 或者 'softtabstop'(smarttab off) 或者 tabstop(smarttab off && softtabstop = 0)
-- 非行首的 <Tab>: 长度是 'softtabstop' 或者 tabstop(softtabstop=0)
-- > 和 < 的缩进长度由 shiftwidth 决定
-- expandtab: 置位时 tab 按键将解释成空格, 不置位时将 tab 按键解释成 shiftwidth或softtabstop个空格,当达到 tabstop 的之时合并成一个 tab(\t)
-- 例子: shiftwidth=4 tabstop=8 softtabstop=4 noexpandtab 时, 按一次 TAB 是 4 个空格,按两次 TAB 是 TAB 符号,按3次 TAB 是一个 TAB 符号,加上 4 个空格
opt.smarttab = true
--- 行首的 <Tab> 根据 'shiftwidth' 插入或删除空白
opt.shiftwidth = 4 -- 缩进宽度
opt.expandtab = true -- 将制表符转换为空格
opt.tabstop = 4 -- 将 TAB 显示成多少宽度
opt.autoindent = true -- 自动缩进
opt.cindent = true -- 打开 C/C++ 语言缩进优化
opt.smartindent = true -- make indenting smarter again

opt.foldenable = true -- 允许代码折叠
-- opt.foldmethod = "indent" -- 代码折叠默认使用缩进
opt.foldmethod = "marker" -- 代码折叠默认使用标记
-- opt.foldlevel = 99        -- 默认打开所有缩进
