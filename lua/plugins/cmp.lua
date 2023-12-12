return {
    {"onsails/lspkind.nvim"},
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            local cmp = require("cmp")
            local function border(hl_name)
            return {
                { "╭", hl_name },
                { "─", hl_name },
                { "╮", hl_name },
                { "│", hl_name },
                { "╯", hl_name },
                { "─", hl_name },
                { "╰", hl_name },
                { "│", hl_name },
            }
            end
            local user_opts = {
                completion = {
                    completeopt = "menu,menuone",
                },
                view = {
                    entries = {name = 'custom', selection_order = 'near_cursor' }
                },
                window = {
                    completion = {
                        border = border "CmpBorder",
                        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
                        scrollbar = false,
                    },
                    documentation = {
                        border = border "CmpDocBorder",
                        winhighlight = "Normal:CmpDoc",
                    },
                },
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                        else
                            fallback()
                        end
                    end, {
                            "i",
                            "s",
                        }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                        else
                            fallback()
                        end
                    end, {
                            "i",
                            "s",
                        }),
                },
                formatting = {
                    format = function(entry, item)
                        local text = item.kind
                        local icons = require("lazyvim.config").icons.kinds[item.kind]
                        local kind = require("lspkind").cmp_format({ mode = "symbol", maxwidth = 50 })(entry, item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (icons or strings[1] or "") .. text
                        kind.menu = "(" .. (strings[2] or "") .. ")"

                        return kind
                    end,
                },
            }
            return vim.tbl_deep_extend("force", opts, user_opts)
        end,
    },
}
