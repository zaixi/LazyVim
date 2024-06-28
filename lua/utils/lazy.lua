local M = {}

local utils = require("utils.replace_keys")
local Meta = require("lazy.core.meta")
local original_add = Meta.add

function Meta:add(spec)
  spec = utils.hook_keys(spec)
  original_add(self, spec)
end

return M
