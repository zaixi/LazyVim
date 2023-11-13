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

local Util = require("lazyvim.util")

M.safe_keymap_set = vim.deepcopy(Util.safe_keymap_set)

-- 重写按键映射函数实现保存默认映射表
function Util.safe_keymap_sett(mode, lhs, rhs, opts)
  print("xxx")
  --M.safe_keymap_set(mode, lhs, rhs, opts)
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

-- 自定义按键映射和保存映射表
--- Table based API for setting keybindings
---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? table A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  base = base or {}
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base
        if type(options) == "table" then
          cmd = options[1]
          keymap_opts["desc"] = options[2]
          keymap_opts["name"] = options["name"]
          keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options.opts or {})
        end
        if not cmd or keymap_opts.name then -- if which-key mapping, queue it
          if not keymap_opts.name then
            keymap_opts.name = keymap_opts.desc
          end
          if not M.which_key_queue then
            M.which_key_queue = {}
          end
          if not M.which_key_queue[mode] then
            M.which_key_queue[mode] = {}
          end
          M.which_key_queue[mode][keymap] = keymap_opts
        else -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
  if package.loaded["which-key"] then
    M.set_all_keymap()
  end -- if which-key is loaded already, register
end

-- 保存 lazy 加载的映射表
function M.save_plugins_mappings(map_table)
  if not M.plugins_mappings then
    M.plugins_mappings = M.empty_map_table()
  end
  -- iterate over each keybinding set in the map_table
  for _, options in pairs(vim.deepcopy(map_table) or {}) do
    if type(options) == "table" then
      local opts = vim.deepcopy(options)
      local keymap = {}
      local key = opts[1]
      local modes = type(opts["mode"]) == "string" and { opts["mode"] } or opts["mode"]
      opts["mode"] = nil

      keymap[1] = opts[2]
      opts[1] = nil
      opts[2] = nil
      if opts["desc"] then
        keymap[2] = opts["desc"]
        opts["desc"] = nil
      end
      keymap["opts"] = opts
      for _, mode in pairs(modes) do
        M.plugins_mappings[mode][key] = keymap
      end
    end
  end
end

-- 保存需要删除的映射
function M.del_keymap(mode, lhs, rhs, opts)
  if not M.del_mappings then
    M.del_mappings = M.empty_map_table()
  end

  local modes = type(mode) == "string" and { mode } or mode
  -- do not create the keymap if a lazy keys handler exists
  if #modes > 0 then
    opts = opts or {}
    for _, mode_single in pairs(modes) do
      M.del_mappings[mode_single][lhs] = opts
    end
  end
end

M.remove_disabled_keys = function(chadrc_mappings, default_mappings)
  if not chadrc_mappings then
    return default_mappings
  end

  -- store keys in a array with true value to compare
  local keys_to_disable = M.empty_map_table()
  --for _, mappings in pairs(chadrc_mappings) do
  for mode, section_keys in pairs(chadrc_mappings) do
    section_keys = (type(section_keys) == "table" and section_keys) or {}
    for k, _ in pairs(section_keys) do
      keys_to_disable[mode][k] = true
    end
  end
  --end

  -- make a copy as we need to modify default_mappings
  --for section_name, section_mappings in pairs(default_mappings) do
  for mode, mode_mappings in pairs(default_mappings) do
    mode_mappings = (type(mode_mappings) == "table" and mode_mappings) or {}
    for k, _ in pairs(mode_mappings) do
      -- if key if found then remove from default_mappings
      if keys_to_disable[mode] and keys_to_disable[mode][k] then
        default_mappings[mode][k] = nil
      end
    end
  end
  --end

  return default_mappings
end

function M.register_which_key(keymaps)
  if type(keymaps) == "table" then
    local wk_avail, wk = pcall(require, "which-key")
    if wk_avail then
      for mode, registration in pairs(keymaps) do
        if next(registration) ~= nil then
          -- print(vim.inspect(registration))
          wk.register(registration, { mode = mode })
        end
      end
    end
  end
end

--- Register queued which-key mappings
function M.set_all_keymap()
  -- 保存 lazy 加载的映射表
  for name, options in pairs(require("lazy.core.config").spec.plugins) do
    if type(options.keys) == "function" then
      --print(name)
    else
      M.save_plugins_mappings(options.keys or {})
    end
  end

  -- 合并开源框架默认映射和自定义映射
  M.default_mappings = M.remove_disabled_keys(M.del_mappings, M.plugins_mappings)
  --print(vim.inspect(M.default_mappings))

  --M.register_which_key(M.plugins_mappings)

  M.register_which_key(M.which_key_queue or nil)
end

function M.replace_keys(spec)
  return spec
end

function M.init_replace_keys()
end

return M
