local M = {}

local Util = require("lazy.core.util")
local Plugin = require("lazy.core.plugin")
local utils = require("utils.replace_keys")

---@param spec LazySpec|LazySpecImport
---@param results? string[]
function Plugin.Spec:normalize(spec, results)

  if type(spec) == "string" then
    if not spec:find("/", 1, true) then
      -- spec is a plugin name
      if results then
        table.insert(results, spec)
      end
    else
      spec = utils.hook_keys({spec})
      self:add( spec, results)
    end
  elseif #spec > 1 or Util.is_list(spec) then
    ---@cast spec LazySpec[]
    for _, s in ipairs(spec) do
      self:normalize(s, results)
    end
  elseif spec[1] or spec.dir or spec.url then
    ---@cast spec LazyPlugin
    spec = utils.hook_keys(spec)
    local plugin = self:add(spec, results)
    ---@diagnostic disable-next-line: cast-type-mismatch
    ---@cast plugin LazySpecImport
    if plugin and plugin.import then
      self:import(plugin)
    end
  elseif spec.import then
    ---@cast spec LazySpecImport
    self:import(spec)
  else
    self:error("Invalid plugin spec " .. vim.inspect(spec))
  end
  return results

end

return M
