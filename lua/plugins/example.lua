-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

return {
--{
--  "coffebar/neovim-project",
--  opts = {
--    projects = { -- define project roots
--      "~/projects/*",
--      "~/.config/*",
--    },
--  },
--  init = function()
--    -- enable saving the state of plugins in the session
--    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
--  end,
--  dependencies = {
--    { "nvim-lua/plenary.nvim" },
--    { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
--    { "Shatur/neovim-session-manager" },
--  },
--  lazy = false,
--  priority = 100,
--},
    -- 自动设置tab
    {
        "tpope/vim-sleuth",
    },
    -- 标签浏览
    {
        "hedyhli/outline.nvim",
        opts = {
            preview_window = {
                auto_preview = true,
                live = true,
            }
        }
    },

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
                enabled = true, -- enables the Noice cmdline UI
                view = "cmdline",
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
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        config = function()
            local options = {
                 default_mappings = false,
            }
            require'marks'.setup(options)
        end
    },
    -- vim 中文文档
    {"yianwillis/vimcdoc", event = "BufRead",},
    -- sudo 读写文件
    {"lambdalisue/suda.vim", cmd = { "SudaWrite", "SudaRead"}},
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
                add = { text = "" },
                change = { text = "" },
                delete = { text = "" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            current_line_blame_formatter = '<abbrev_sha>: <author>, <author_time:%Y-%m-%d> - <summary>',
            on_attach = function() end,
        },
    },
    --{
    --    "folke/edgy.nvim",
    --    opts = function(_, opts)
    --        opts.keys["<A-Left>"]  = vim.deepcopy(opts.keys["<c-left>"])
    --        opts.keys["<A-Right>"] = vim.deepcopy(opts.keys["<c-Right>"])
    --        opts.keys["<A-Up>"]    = vim.deepcopy(opts.keys["<c-Up>"])
    --        opts.keys["<A-Down>"]  = vim.deepcopy(opts.keys["<c-Down>"])
    --        opts.keys["<C-Right>"] = nil
    --        opts.keys["<C-Left>"]  = nil
    --        opts.keys["<C-Up>"]    = nil
    --        opts.keys["<C-Down>"]  = nil
    --    end,
    --},
    -- 在驼峰式和 Snek 式（以及 kebab 式）之间转换
    {"nicwest/vim-camelsnek", cmd = {"Snek", "Camel", "CamelB", "Kebab", "Screm"}},
    {
        'echasnovski/mini.align',
        event = "VeryLazy",
        opts = function ()
            return {
                mappings = {
                    start = 'ga',
                    start_with_preview = '<leader>ca',
                },
            }
        end,
        --config = function ()

        --    require("mini.align").setup()
        --end
    },
    {
        "folke/which-key.nvim",
        opts = {
            notify = false,
            preset = "modern",
        },
    },
    --{"YacineDo/mc.nvim", event = "VeryLazy"},

  --- }}}
}
