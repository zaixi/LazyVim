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
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
                            cmp.select_next_item()
                        elseif vim.snippet.active({ direction = 1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(1)
                            end)
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.snippet.active({ direction = -1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(-1)
                            end)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
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
