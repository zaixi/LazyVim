return {
    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            local actions = require "telescope.actions"
            local user_opts = {
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = " ",
                    mappings = {
                        i = {
                            ['<c-e>'] = require('telescope.actions.layout').toggle_preview,
                            ["<M-h>"] = actions.results_scrolling_left,
                            ["<M-l>"] = actions.results_scrolling_right,
                            ["<C-h>"] = actions.preview_scrolling_left,
                            ["<C-l>"] = actions.preview_scrolling_right,
                            ["<C-f>"] = actions.preview_scrolling_down,
                            ["<C-b>"] = actions.preview_scrolling_up,
                        }
                    },
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        center = {
                            anchor = 'S',
                            prompt_position = "top",
                            height = 0.4,
                            preview_cutoff = 0
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    --path_display = { "truncate" },
                    path_display = { "smart" },
                }
            }
            return vim.tbl_deep_extend("force", opts, user_opts)
        end,
    }
}
