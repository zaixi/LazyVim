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

-- 保存需要删除的映射
function M.del_keymap(keymap)
  local lhs = keymap[1]
  local desc = keymap[2] or true
  local mode = keymap.mode or {"n"}
  local modes = type(mode) == "string" and { mode } or mode

  if #modes > 0 then
    for _, mode_single in pairs(modes) do
      M.del_mappings[mode_single][lhs] = desc
    end
  end
end

-- 重写按键映射函数实现保存默认映射表
function M.safe_keymap_set(mode, lhs, rhs, opts)
    local spec = { [1] = "default_key", keys = {}}
    spec.keys[1] = opts or {}
    local key = spec.keys[1]
    key[1] = lhs
    key[2] = rhs
    key.mode = mode
    M.hook_keys(spec)
    for _, keymap in ipairs(spec.keys) do
        mode = keymap.mode
        lhs = keymap[1]
        rhs = keymap[2]
        keymap.mode = nil
        keymap[1] = nil
        keymap[2] = nil
        M.default_safe_keymap_set(mode, lhs, rhs, keymap)
    end
end

function M.hook_replace_key(spec, mode, index, key)
    local del_desc = M.del_mappings[mode][key[1]] or nil
    local replace = M.replace_keys[mode][key[1]] or nil
    local back_key = vim.deepcopy(spec.keys[index])

    if del_desc == true or (del_desc == back_key.desc and del_desc ~= nil) then
      return
    end
    -- 替换表存在这个映射
    --print(vim.inspect(spec.keys[index]))
    --print(vim.inspect(M.replace_keys[mode]))
    --print(vim.inspect(key))
    if replace then
        back_key.desc = replace.custom.desc
        back_key[1] = replace.custom.lhs
        back_key.mode = mode
        if replace.custom.rhs then back_key[2] = vim.deepcopy(replace.custom.rhs) end
        -- 替换表是删除
        if replace.custom.del == true then
            M.replace_keys_used[mode][key[1]] = replace
        -- 替换表和映射描述一致就替换
        elseif key.desc == replace.default.desc then
            M.replace_keys_used[mode][key[1]] = replace
            table.insert(spec.replace_keys, back_key)
        -- 替换表和映射描述不一致就报错
        else
            print(spec[1], "replace map error: ", vim.inspect(key), replace.default.desc)
        end
    else
        -- 不存在替换表就报错
        --print(spec[1], "no replace map: ", vim.inspect(key))
        M.default_keys = M.default_keys or M.empty_map_table()
        back_key["plug"] = spec[1]
        M.default_keys[mode][key[1]] = vim.tbl_extend("force", M.default_keys[mode][key[1]] or {}, back_key)
    end
end

function M.hook_keys(spec)
    -- 存在映射表就尝试替换
  if type(spec["keys"]) == "table" then
    if spec.replace_keys == nil then spec.replace_keys = {} end
    -- 遍历单个插件的每个映射
    for index, key in pairs(spec.keys) do
        local modes = key.mode or {"n"}
        modes = type(modes) == "string" and { modes } or modes
        for _, mode_single in pairs(modes) do
            M.hook_replace_key(spec, mode_single, index, key)
        end
    end
    spec.keys = spec.replace_keys
  elseif spec["keys"] then
    if spec[1] ~= "echasnovski/mini.surround" then
      print(spec[1].. "keys is function", vim.inspect(spec))
    end
  end
  return spec
end

function M.init_replace_keys()
    M.replace_keys = M.empty_map_table()
    M.replace_keys_used = M.empty_map_table()
    M.del_mappings = M.empty_map_table()
    M.default_keys = nil
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

function M.show_keys()
    local not_use_keys = nil
    local have_default_keys = nil
    for mode, keys in pairs(M.replace_keys) do
        for index, _ in pairs(keys) do
            if M.replace_keys_used[mode][index] == nil then
                not_use_keys = M.empty_map_table()
                not_use_keys[mode][index] = M.replace_keys[mode][index]
            end
        end
    end
    if type(not_use_keys) == "table" then
        vim.notify("don't use replace keys in :" .. vim.inspect(not_use_keys), vim.log.levels.WARN)
    end

    for mode, keys in pairs(M.default_keys or {}) do
        for _, _ in pairs(keys) do
            have_default_keys = have_default_keys or {}
            have_default_keys[mode] = keys
            break
        end
    end
    if have_default_keys then
        vim.notify("don't replace default keys in :" .. vim.inspect(have_default_keys), vim.log.levels.WARN)
    end
end

return M
