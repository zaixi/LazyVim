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


--复制按键映射表初始化函数，便于其他函数换了框架也能使用
--- Get an empty table of mappings with a key for each map mode
---@return table<string,table> # a table with entries for each map mode
function M.empty_map_table()
  local maps = {}
  for _, mode in ipairs({ "", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t" }) do
    maps[mode] = {}
  end
  if vim.fn.has("nvim-0.10.0") == 1 then
    for _, abbr_mode in ipairs({ "ia", "ca", "!a" }) do
      maps[abbr_mode] = {}
    end
  end
  return maps
end

-- 重写按键映射函数实现保存默认映射表
function M.safe_keymap_set(mode, lhs, rhs, opts)
  print("xxxa")
  M.default_safe_keymap_set(mode, lhs, rhs, opts)
  if not M.plugins_mappings then
    M.plugins_mappings = M.empty_map_table()
  end
  local modes = type(mode) == "string" and { mode } or mode
  if #modes > 0 then
    opts = opts or {}

    local keymap = {}
    keymap[1] = rhs
    if opts["desc"] then
      keymap[2] = opts["desc"]
      opts["desc"] = nil
    end
    keymap["opts"] = opts
    for _, mode_single in pairs(modes) do
      M.plugins_mappings[mode_single][lhs] = keymap
    end
  end
end

function M.hook_replace_key(spec, mode, index, key)
    local replace = M.replace_keys[mode][key[1]] or nil
    -- 替换表存在这个映射
    --print(vim.inspect(spec.keys[index]))
    --print(vim.inspect(M.replace_keys[mode]))
    --print(vim.inspect(key))
    if replace then
        -- 替换表是删除
        if replace.custom.del == true then
            spec.keys[index] = nil
            M.replace_keys_used[mode][key[1]] = replace
            M.replace_keys[mode][key[1]] = nil
        -- 替换表和映射描述一致就替换
        elseif key.desc == replace.default.desc then
            M.replace_keys_used[mode][key[1]] = replace
            spec.keys[index].desc = replace.custom.desc
            spec.keys[index][1] = replace.custom.lhs
            if replace.custom.rhs then spec.keys[index][2] = vim.deepcopy(replace.custom.rhs) end
            M.replace_keys[mode][key[1]] = nil
        -- 替换表和映射描述不一致就报错
        else
            print(spec[1], "replace map error: ", vim.inspect(key), replace.default.desc)
        end
    else
        -- 不存在替换表就报错
        print(spec[1], "no replace map: ", vim.inspect(key))
    end
end

function M.hook_keys(spec)
    -- 存在映射表就尝试替换
  if type(spec["keys"]) == "table" then
    spec.replace_keys = {}
    -- 遍历单个插件的每个映射
    for index, key in pairs(spec.keys) do
        local modes = key.mode or {"n"}
        modes = type(modes) == "string" and { modes } or modes
        for _, mode_single in pairs(modes) do
            M.hook_replace_key(spec, mode_single, index, key)
        end
    end
  elseif spec["keys"] then
    if spec[1] ~= "echasnovski/mini.surround" then
      print(vim.inspect(spec))
    end
  end
  return spec
end

function M.init_replace_keys()
  --local Util = require("lazy.core.util")
  --local Plugin = require("lazy.core.plugin")
  --local utils = require("utils.replace_keys")

    M.replace_keys = M.empty_map_table()
    M.replace_keys_used = M.empty_map_table()
    require("config.keys")
end

function M.add_replace_keys(custom_keys, default_keys)
  local default = {}
  local custom = {}
  local modes = default_keys.mode or {"n"}
  modes = type(modes) == "string" and { modes } or modes
  default.lhs = default_keys[1]
  default.desc = default_keys[2]
  if custom_keys == nil then
    custom.del = true
  else
    custom.lhs = custom_keys.lhs or default_keys[1]
    custom.desc = custom_keys.desc or default_keys[2]
    custom.rhs = custom_keys.rhs or nil
  end
    for _, mode_single in pairs(modes) do
    if M.replace_keys[mode_single][default.lhs] then
            print(default.lhs, " mapping conflict!")
            print("old key:", vim.inspect(M.replace_keys[mode_single][default.lhs]))
            print("new key:", vim.inspect(default_keys))
    else
      M.replace_keys[mode_single][default.lhs] = { default = default, custom = custom }
    end
    end
end

return M
