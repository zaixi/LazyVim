return {
    {
        'gelguy/wilder.nvim',
        dependencies = {
            {'romgrk/fzy-lua-native'},
        },
        build = function()
            vim.cmd("! pip3 install pynvim")
            vim.cmd(":UpdateRemotePlugins")
        end,
        event = 'CmdlineEnter',
        config = function()
            vim.cmd [[
                call wilder#setup({'modes': [':']})

                call wilder#set_option('pipeline', [
                    \   wilder#debounce(10),
                    \   wilder#branch(
                    \     wilder#substitute_pipeline({
                    \       'pipeline': wilder#python_search_pipeline({
                    \         'skip_cmdtype_check': 1,
                    \         'pattern': wilder#python_fuzzy_pattern({
                    \           'start_at_boundary': 0,
                    \         }),
                    \       }),
                    \     }),
                    \     wilder#cmdline_pipeline({
                    \       'fuzzy': 1,
                    \       'fuzzy_filter': wilder#vim_fuzzy_filter(),
                    \     }),
                    \     [
                    \       wilder#check({_, x -> empty(x)}),
                    \       wilder#history(),
                    \     ],
                    \     wilder#python_search_pipeline({
                    \       'pattern': wilder#python_fuzzy_pattern(),
                    \       'sorter': wilder#python_difflib_sorter(),
                    \       'engine': 're',
                    \     }),
                    \   ),
                    \ ])

                let s:highlighters = [
                    \ wilder#pcre2_highlighter(),
                    \ has('nvim') ? wilder#lua_fzy_highlighter() : wilder#cpsm_highlighter(),
                    \ ]

                ""let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
                let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
                    \ 'pumblend': 20,
                    \ 'border': 'rounded',
                    \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
                    \ 'highlighter': s:highlighters,
                    \ 'highlights': {
                    \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
                    \ },
                    \ 'left': [
                    \   ' ',
                    \   wilder#popupmenu_devicons(),
                    \   wilder#popupmenu_buffer_flags({
                    \     'flags': ' a + ',
                    \     'icons': {'+': '', 'a': '', 'h': ''},
                    \   }),
                    \ ],
                    \ 'right': [
                    \   ' ',
                    \   wilder#popupmenu_scrollbar(),
                    \ ],
                    \ }))

                let s:wildmenu_renderer = wilder#wildmenu_renderer({
                    \ 'highlighter': s:highlighters,
                    \ 'separator': ' · ',
                    \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
                    \ 'right': [' ', wilder#wildmenu_index()],
                    \ })

                call wilder#set_option('renderer', wilder#renderer_mux({
                    \ ':': s:popupmenu_renderer,
                    \ '/': s:wildmenu_renderer,
                    \ 'substitute': s:wildmenu_renderer,
                    \ }))
            ]]
        end
    },
}

