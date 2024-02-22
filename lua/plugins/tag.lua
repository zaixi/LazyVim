return {
    -- taglist {{{
    {
        "skywind3000/vim-gutentags",
        build = function()
            local chmod_cmd = "! chmod +x " .. vim.fn.stdpath "data" .. "/lazy/vim-gutentags/plat/unix/update_gtags.sh"
            vim.cmd("! pip3 install pygments")
            vim.cmd(chmod_cmd)
        end,
        init = function()
            -- require("core.lazy_load").lazy_load {
            --     events = { "BufNewFile", "BufRead", "TabEnter" },
            --     augroup_name = "GutentagsLazy",
            --     plugins = "vim-gutentags",
            --
            --     condition = function ()
            vim.cmd [[
            let $GTAGSLABEL = 'native-pygments'
            if filereadable(expand("$HOME/.gtags.conf"))
            let $GTAGSCONF = expand("$HOME/.gtags.conf")
            endif
            " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
            let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
            let g:gutentags_plus_nomap = 1
            let g:gutentags_plus_use_telescope = 1
            let g:gutentags_define_advanced_commands = 1
            " let g:gutentags_debug = 1
	    " 关闭保存时自动更新
	    let g:gutentags_generate_on_write = 0

            " 所生成的数据文件的名称
            let g:gutentags_ctags_tagfile = '.tags'

            " 同时开启 ctags 和 gtags 支持：
            let g:gutentags_modules = []
            if executable('gtags-cscope') && executable('gtags')
            let g:gutentags_modules += ['gtags_cscope']
            elseif executable('ctags')
            let g:gutentags_modules += ['ctags']
            endif

            " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
            let g:gutentags_cache_dir = expand('~/.cache/tags')

            " 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
            let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
            let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
            let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

            " 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
            let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

            " 禁用 gutentags 自动加载 gtags 数据库的行为
            let g:gutentags_auto_add_gtags_cscope = 0
            ]]
            --     end
            -- }
            -- require("core.lazy_load").on_file_open "vim-gutentags"
        end
    },
    {"zaixi/gutentags_plus", cmd = {'GscopeFind', 'GscopeSwitchLayout'}},

}
