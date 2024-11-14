local M = {}

vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/snacks.nvim")
local utils = require("utils.replace_keys")
local Meta = require("lazy.core.meta")
local snacks = require("snacks")
local original_add = Meta.add

function Meta:add(spec)
  spec = utils.hook_keys(spec)
  original_add(self, spec)
end

function snacks.toggle:_wk(keys, mode)
  if not LazyVim.has("which-key.nvim") then
    return
  end
  require("which-key").add({
    {
      keys,
      mode = mode,
      icon = function()
        local key = self:get() and "enabled" or "disabled"
        return {
          icon = type(self.opts.icon) == "string" and self.opts.icon or self.opts.icon[key],
          color = type(self.opts.color) == "string" and self.opts.color or self.opts.color[key],
        }
      end,
      desc = function()
        return (self:get() and "关闭 " or "开启 ") .. self.opts.name
      end,
    },
  })
end

return M
