local M = {}

local utils = require("utils.replace_keys")
local Meta = require("lazy.core.meta")
local original_add = Meta.add

function Meta:add(spec)
  spec = utils.hook_keys(spec)
  original_add(self, spec)
end

function M.wk(lhs, toggle)
  if not LazyVim.has("which-key.nvim") then
    return
  end
  require("which-key").add({
    {
      lhs,
      icon = function()
        return toggle.get() and { icon = " ", color = "green" } or { icon = " ", color = "yellow" }
      end,
      desc = function()
        return (toggle.get() and "关闭 " or "开启 ") .. toggle.name
      end,
    },
  })
end

return M
