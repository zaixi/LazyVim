local M = {}

vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/snacks.nvim")
local utils = require("utils.replace_keys")
local Meta = require("lazy.core.meta")
local snacks = require("snacks")
local snacks_toggle = snacks.toggle
local original_add = Meta.add

function Meta:add(spec)
  spec = utils.hook_keys(spec)
  original_add(self, spec)
end

-- 验证 snacks_toggle.new()
local instance = snacks_toggle.new({ name = "test_toggle" })
if not instance then
    error("snacks_toggle.new() returned nil. Please check the implementation of the `new` function.")
end

-- 验证 metatable 和 __index
local mt = getmetatable(instance)
if not (mt and mt.__index) then
    error("The instance metatable or `__index` is missing. Check the `setmetatable` call.")
end

local original_map = mt.__index.map

mt.__index.map = function(self, keys, opts)
  opts = opts or {}
  --print("Custom map with keys:", keys, "and mode:", opts.mode or "n", "desc:", self.opts.name)
  key, name = utils.snacks_keymap_set(opts.mode, keys, nil, {desc = self.opts.name})
  keys = key or keys
  self.opts.name = name or self.opts.name
  return original_map(self, keys, opts)
end

-- Hook _wk 方法
mt.__index._wk = function(self, keys, mode)
    --print("Custom _wk called with keys:", keys, "and mode:", mode, "desc:", self.opts.name)
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

mt.__index.toggle = function(self)
  local state = not self:get()
  self:set(state)
  if self.opts.notify then
    Snacks.notify(
      (state and "开启" or "关闭") .. " **" .. self.opts.name .. "**",
      { title = self.opts.name, level = state and vim.log.levels.INFO or vim.log.levels.WARN }
    )
  end
end

return M
