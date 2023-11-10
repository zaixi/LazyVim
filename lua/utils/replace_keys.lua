--- ### AstroNvim Utilities
--
-- Various utility functions to use within AstroNvim and user configurations.
--
-- This module can be loaded with `local utils = require "astronvim.utils"`
--
-- @module astronvim.utils
-- @copyright 2022
-- @license GNU General Public License v3.0

local M = {}
M.keys = {}

function M.hook_keys(spec)
  if type(spec["keys"]) == "table" then
  --print(vim.inspect(spec["keys"]))
  --  print("==============")
    for key, value in pairs(spec.keys) do
      local replace = M.keys[value[1]] or nil
      if replace then
        if value.desc == replace.default.desc then
          if replace.use == true then
            print(spec[1], "map already used: ", vim.inspect(value))
          end
          spec.keys[key].desc = replace.custom.desc
          spec.keys[key][1] = replace.custom.lhs
          replace.use = true
        else if replace.default.del == true then
          spec.keys[key] = nil
          replace.use = true
        end
          print(spec[1], "map error: ", vim.inspect(value))
        end
      end
    end
  else if spec["keys"] then
    if spec[1] ~= "echasnovski/mini.surround" then
      print(vim.inspect(spec))
    end
  end
  end
  return spec
end

function M.init_replace_keys()
  --local Util = require("lazy.core.util")
  --local Plugin = require("lazy.core.plugin")
  --local utils = require("utils.replace_keys")

  require("config.keys")
end

function M.replace_keys(default_keys, custom_keys)
  --table.insert(M.keys, {old_keys, new_keys})
  local default = {}
  local custom = {}
  default.lhs = default_keys[1]
  default.desc = default_keys[2]
  custom.lhs = custom_keys[1]
  custom.desc = custom_keys[2]
  M.keys[default.lhs] = { default = default, custom = custom }
end

return M
