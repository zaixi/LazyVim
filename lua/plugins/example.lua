-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {

    -- 快速移动
    {
        "folke/flash.nvim",
        opts = {
            modes = {
                char = {
                    jump_labels = true
                }
            }
        }
    },
    -- 通知等增强
    {
        "folke/noice.nvim",
        opts = {
            cmdline = {
                enabled = false, -- enables the Noice cmdline UI
            }
        }
    },

    -- 显示 #if #endif 匹配词
    {
        "andymass/vim-matchup",
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end
    },
    -- 撤销树
    { "mbbill/undotree", cmd = "UndotreeToggle" },
    -- 快速对齐，代替 Tabularize
    {"junegunn/vim-easy-align", cmd = "EasyAlign"},
    -- 重复上次操作
    { "tpope/vim-repeat", event = "VeryLazy" },
    -- 多行编辑
    { "mg979/vim-visual-multi", event = "VeryLazy" },
    -- Doxygen风格注释
    {"vim-scripts/DoxygenToolkit.vim", cmd = {'Dox', 'DoxLic', 'DoxAuthor'}},
    -- 去除行尾空格
    { "ntpeters/vim-better-whitespace", cmd = {"EnableWhitespace", "DisableWhitespace", "ToggleWhitespace", "StripWhitespace"}},

  --- 功能增强 {{{

    -- coding {{{
    -- 注释
    { "echasnovski/mini.comment", enabled = false },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            toggler = {
                ---Line-comment toggle keymap
                line = 'gc',
                ---Block-comment toggle keymap
                block = 'gb',
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Line-comment keymap
                line = 'gc',
                ---Block-comment keymap
                block = 'gb',
            },
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
    },
    -- }}}
    -- tmux 和 vim 导航
    { "christoomey/vim-tmux-navigator", cmd = {"TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight"} },
    -- 翻译软件，需要安装 soimort/translate-shell
    {
        "uga-rosa/translate.nvim",
        cmd = "Translate",
        config = function()
            local options = {
                default = {
                    command = "translate_shell",
                    output = "floating",
                    parse_before = "trim,natural",
                    parse_after = "window",
                },
                silent = true,
            }
            require("translate").setup(options)
        end
    },
    -- vim 中文文档
    {"yianwillis/vimcdoc", event = "BufRead",},
    -- sudo 读写文件
    {"lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead"}},
    -- 轻松重新排列
    {"sindrets/winshift.nvim", cmd = 'WinShift '},
    -- 在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转或交换位置
    {'t9md/vim-choosewin', cmd = {'ChooseWin', 'ChooseWinSwap'}},
    -- }}}
    -- lualine integration
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            table.insert(opts.sections.lualine_c, {
                function() return "Gen. " .. vim.fn['gutentags#statusline']() end,
                cond = function() return vim.fn['gutentags#statusline']() ~= "" end,
            })
            opts.sections.lualine_y = {
                {
                    function ()
                        local col = vim.fn.virtcol('.')
                        local cur = vim.fn.line('.')
                        local total = vim.fn.line('$')
                        if cur == 1 then
                            return string.format('%d:Top', col)
                        elseif cur == total then
                            return string.format('%d:Bot', col)
                        else
                            return string.format('%d:%2d%%%%', col, math.floor(cur / total * 100))
                        end
                    end,
                    separator = ":", padding = { left = 1, right = 1 }
                },
            }
            opts.sections.lualine_z = {}
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { hl = "DiffAdd", text = "", numhl = "GitSignsAddNr" },
                change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
                delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
                topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
                changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
            },
            current_line_blame_formatter = '<abbrev_sha>: <author>, <author_time:%Y-%m-%d> - <summary>',
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghd", function() vim.wo.diff=false gs.diffthis() end, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },
    -- 在驼峰式和 Snek 式（以及 kebab 式）之间转换
    {"nicwest/vim-camelsnek", cmd = {"Snek", "Camel", "CamelB", "Kebab", "Screm"}},

  --- }}}
}
