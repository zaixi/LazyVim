local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local snackspath = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
if not vim.loop.fs_stat(snackspath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/snacks.nvim.git", "--branch=stable", snackspath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
vim.opt.rtp:prepend(vim.env.LAZY or snackspath)

-- hook lazy.Plugin.Spec:normalize 劫持按键
require("utils.lazy")
-- init custom keys
require("utils.replace_keys").init_replace_keys()
-- hook LazyVim.util.safe_keymap_set 劫持按键
local function lazyvim_custom()
  local Util = require("lazyvim.util")
  local utils = require("utils.replace_keys")
  local Toggle = require("lazyvim.util")
  local toggle = require("utils.lazy")

  utils.default_safe_keymap_set = vim.deepcopy(Util.safe_keymap_set)
  Util.safe_keymap_set = utils.safe_keymap_set
end

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins", init = lazyvim_custom },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "lazyvim.plugins.extras.util.project" },
    { import = "lazyvim.plugins.extras.ui.edgy" },
    { import = "lazyvim.plugins.extras.editor.outline" },
    { import = "lazyvim.plugins.extras.editor.navic" },
    { import = "lazyvim.plugins.extras.editor.dial" },
    { import = "lazyvim.plugins.extras.editor.inc-rename" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    { import = "lazyvim.plugins.extras.editor.illuminate" },
    --{ import = "lazyvim.plugins.extras.coding.luasnip" },
    { import = "lazyvim.plugins.extras.util.startuptime" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.ai.copilot" },
    { import = "lazyvim.plugins.extras.ai.supermaven" },
    { import = "lazyvim.plugins.extras.ai.codeium" },
    --{ import = "lazyvim.plugins.extras.ai.tabnine" },
    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
