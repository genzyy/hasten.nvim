local ui = require("hasten.ui")
local vim_api = vim.api
local utils = {}

--- @return integer
utils.get_current_bufnr = function() return vim_api.nvim_get_current_buf() end

--- @param bufnr integer
utils.set_current_bufnr = function(bufnr) vim.api.nvim_set_current_buf(bufnr) end

--- @param maps table
utils.show_remaps = function(maps)
  local contents = {}
  for key, value in pairs(maps) do
    local line = key .. "  =>  " .. value
    table.insert(contents, line)
  end

  local popup_cb = function(_, _sel) end

  local bufnr = ui.show_window({}, popup_cb)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
end

utils.close_remaps = function() ui.close_window() end


--- @param main_key "control" | "alt" | "leader"
--- @param sub_key string
--- @return string
function utils._map_current_buffer(main_key, sub_key)
  if main_key == "control" then
    return "<C-" .. sub_key .. ">"
  elseif main_key == "alt" then
    return "<A-" .. sub_key .. ">"
  else
    return "<leader>" .. sub_key
  end
end

--- @param parent table
--- @param child table
function utils._extend(parent, child)
  for k, v in pairs(child) do
    parent[k] = v
  end
end

--- @param tb table
--- @return integer
function utils._table_len(tb)
  local len = 0
  for _, _ in pairs(tb) do len = len + 1 end
  return len
end

return utils
