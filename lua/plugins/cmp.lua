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
                },
                cmdline = {
                    enabled = true,
                    completion = {
                        menu = { auto_show = true },
                        ghost_text = { enabled = true },
                    },
                    sources = function()
                        local type = vim.fn.getcmdtype()
                        -- Search forward and backward
                        if type == '/' or type == '?' then return { 'buffer' } end
                        -- Commands
                        if type == ':' or type == '@' then return { 'cmdline' } end
                        return {}
                    end,
                },
            }
            return vim.tbl_deep_extend("force", opts, user_opts)

        end
    }
