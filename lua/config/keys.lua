local map = require("utils.replace_keys").add_replace_keys
local del = require("utils.replace_keys").del_keymap
local def_map = vim.keymap.set

-- "echasnovski/mini.surround"

def_map({"n", "c"}, "<C-a>", "<home>", { desc = "跳到行首"})
def_map({"n", "c"}, "<C-e>", "<home>", { desc = "跳到行尾"})

map({lhs = "<tab>"}, {"<tab>", mode = "i"})
map({lhs = "<tab>"}, {"<tab>", mode = "s"})
map({lhs = "<s-tab>"}, {"<s-tab>", mode = {"i", "s"}})


--- {{{ mini default keymap

-- better up/down
map({lhs = "j", desc = "better j"}, {"j", mode = {"n", "x"}})
map({lhs = "k", desc = "better j"}, {"k", mode = {"n", "x"}})

-- Move to window using the <ctrl> hjkl keys
map({lhs = "<C-h>", desc = "Go to left window"}, {"<C-h>", "Go to left window"})
map({lhs = "<C-j>", desc = "Go to lower window"}, {"<C-j>", "Go to lower window"})
map({lhs = "<C-k>", desc = "Go to upper window"}, {"<C-k>", "Go to upper window"})
map({lhs = "<C-l>", desc = "Go to right window"}, {"<C-l>", "Go to right window"})

-- Resize window using <ctrl> arrow keys
map({lhs = "<C-Up>", desc = "Increase window height"}, {"<C-Up>", "Increase window height"})
map({lhs = "<C-Down>", desc = "Decrease window height"}, {"<C-Down>", "Decrease window height"})
map({lhs = "<C-Left>", desc = "Decrease window width"}, {"<C-Left>", "Decrease window width"})
map({lhs = "<C-Right>", desc = "Increase window width"}, {"<C-Right>", "Increase window width"})

-- Move Lines
map({lhs = "<A-j>", desc = "Move down"}, {"<A-j>", "Move down", mode = {"n", "i", "v"}})
map({lhs = "<A-k>", desc = "Move up"},  {"<A-k>", "Move up", mode = {"n", "i", "v"}})

-- buffers
--map({lhs = "<S-h>", desc = "Prev buffer" }, {"<S-h>", "Prev buffer" })
--map({lhs = "<S-l>", desc = "Next buffer" }, {"<S-l>", "Next buffer" })
--map({lhs = "[b", desc = "Prev buffer" }, {"[b", "Prev buffer" })
--map({lhs = "]b", desc = "Next buffer" }, {"]b", "Next buffer" })
map({lhs = "<leader>bb", desc = "Switch to Other Buffer" }, {"<leader>bb", "Switch to Other Buffer" })
map({lhs = "<leader>`", desc = "Switch to Other Buffer" }, {"<leader>`", "Switch to Other Buffer" })

-- Clear search with <esc>
map({lhs = "<esc>", desc = "Escape and clear hlsearch"}, {"<esc>", "Escape and clear hlsearch", mode = {"i", "n"}})

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
map({lhs = "<C-s>", desc = "Save file"}, {"<C-s>", "Save file", mode = { "i", "x", "n", "s" }})

--keywordprg
map({lhs = "<leader>K", desc = "Keywordprg" }, {"<leader>K", "Keywordprg"})

-- better indenting
map({lhs = "<"}, {"<", mode = "v"})
map({lhs = ">"}, {">", mode = "v"})

-- lazy
map({lhs = "<leader>l", desc = "Lazy" }, {"<leader>l", "Lazy"})

-- new file
map({lhs = "<leader>fn", desc = "New File" }, {"<leader>fn", "New File"})

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
map({lhs = "<leader>uL", desc = "Toggle Relative Line Numbers"}, { "<leader>uL", "Toggle Relative Line Numbers" })
map({lhs = "<leader>ul", desc = "Toggle Line Numbers" }, { "<leader>ul", "Toggle Line Numbers" })
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
map({lhs = "<leader>ft", desc = "Terminal (root dir)"}, { "<leader>ft", "Terminal (root dir)" })
map({lhs = "<leader>fT", desc = "Terminal (cwd)" }, { "<leader>fT", "Terminal (cwd)" })
map({lhs = "<c-/>", desc = "Terminal (root dir)"}, {"<c-/>", "Terminal (root dir)" })
map({lhs = "<c-_>", desc = "which_key_ignore" }, { "<c-_>", "which_key_ignore" })

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
map({lhs = "<leader>wd", desc = "Delete window"}, {"<leader>wd", "Delete window"})
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
map({lhs = "<leader>cm", desc = "Mason"}, {"<leader>cm", "Mason"})
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
map({lhs = "<leader><space>", desc = "Find Files (root dir)"}, {"<leader><space>", "Find Files (root dir)"})
-- find
map({ lhs = "<leader>fb", desc = "Buffers" }, { "<leader>fb", "Buffers" })
map({ lhs = "<leader>fc", desc = "Find Config File" }, { "<leader>fc", "Find Config File" })
map({ lhs = "<leader>ff", desc = "Find Files (root dir)" }, { "<leader>ff", "Find Files (root dir)" })
map({ lhs = "<leader>fF", desc = "Find Files (cwd)" }, { "<leader>fF", "Find Files (cwd)" })
map({ lhs = "<leader>fr", desc = "Recent" }, { "<leader>fr", "Recent" })
map({ lhs = "<leader>fR", desc = "Recent (cwd)" }, { "<leader>fR", "Recent (cwd)" })
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
map({ lhs = "<leader>sg", desc = "Grep (root dir)" }, { "<leader>sg", "Grep (root dir)" })
map({ lhs = "<leader>sG", desc = "Grep (cwd)" }, { "<leader>sG", "Grep (cwd)" })
map({ lhs = "<leader>sh", desc = "Help Pages" }, { "<leader>sh", "Help Pages" })
map({ lhs = "<leader>sH", desc = "Search Highlight Groups" }, { "<leader>sH", "Search Highlight Groups" })
map({ lhs = "<leader>sk", desc = "Key Maps" }, { "<leader>sk", "Key Maps" })
map({ lhs = "<leader>sM", desc = "Man Pages" }, { "<leader>sM", "Man Pages" })
map({ lhs = "<leader>sm", desc = "Jump to Mark" }, { "<leader>sm", "Jump to Mark" })
map({ lhs = "<leader>so", desc = "Options" }, { "<leader>so", "Options" })
map({ lhs = "<leader>sR", desc = "Resume" }, { "<leader>sR", "Resume" })
map({ lhs = "<leader>sw", desc = "Word (root dir)" }, { "<leader>sw", "Word (root dir)" })
map({ lhs = "<leader>sW", desc = "Word (cwd)" }, { "<leader>sW", "Word (cwd)" })
map({ lhs = "<leader>sw", desc = "Selection (root dir)" }, { "<leader>sw", "Selection (root dir)", mode = "v" })
map({ lhs = "<leader>sW", desc = "Selection (cwd)" }, { "<leader>sW", "Selection (cwd)", mode = "v" })
map({ lhs = "<leader>uC", desc = "Colorscheme with preview" }, { "<leader>uC", "Colorscheme with preview" })
map({ lhs = "<leader>ss", desc = "Goto Symbol" }, { "<leader>ss", "Goto Symbol" })
map({ lhs = "<leader>sS", desc = "Goto Symbol (Workspace)" }, { "<leader>sS", "Goto Symbol (Workspace)" })
map({lhs = "s", desc = "Flash"}, {"s", "Flash", mode = { "n", "x", "o" }})
map({lhs = "S", desc = "Flash Treesitter"}, {"S", "Flash Treesitter", mode = { "n", "x", "o" }})
map({lhs = "r", desc = "Remote Flash"}, {"r", "Remote Flash", mode = "o"})
map({lhs = "R", desc = "Treesitter Search"}, {"R", "Treesitter Search", mode = { "o", "x" }})
map({lhs = "<c-s>", desc = "Toggle Flash Search"}, {"<c-s>", "Toggle Flash Search", mode = "c" })
map({lhs = "]]", desc = "Next Reference"}, {"]]", "Next Reference"})
map({lhs = "[[", desc = "Prev Reference"}, {"[[", "Prev Reference"})
map({lhs = "<leader>bd", desc = "Delete Buffer"}, {"<leader>bd", "Delete Buffer"})
map({lhs = "<leader>bD", desc = "Delete Buffer (Force)"}, {"<leader>bD", "Delete Buffer (Force)"})
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
map({lhs = "<TAB>", desc = "  上个 buffer"}, {"<S-h>", "Prev buffer"})
map({lhs = "<S-TAB>", desc = "  下个 buffer"}, {"<S-l>", "Next buffer"})
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
