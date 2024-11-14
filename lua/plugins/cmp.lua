return
    {
        "saghen/blink.cmp",
        opts = function(_, opts)
            local user_opts = {
                keymap = {
                    preset = "enter",
                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },
                },
                signature = { window = { border = "rounded" }},
                completion = {
                    menu = {
                        border = "rounded",
                        draw = {
                            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                        },
                    },
                    documentation = { window = { border = "rounded" } },
                }
            }
            return vim.tbl_deep_extend("force", opts, user_opts)

        end
    }
