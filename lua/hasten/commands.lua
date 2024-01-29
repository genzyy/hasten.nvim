local utils = require("hasten.utils")
local logger = require("hasten.logger")
local command = vim.api.nvim_create_user_command
local keymap = vim.keymap
local default_opts = {
  count = true,
  bang = true,
  nargs = "*",
  desc = "Custom key map for buffers",
}

local M = {}

M._view_maps = false

M._maps = {}

M._user_defined_maps = {}

--- @param config HastenConfig
--- @param default_maps table
M.create_user_commands = function(config, default_maps)
  M._user_defined_maps = config.predefined_keymaps
  local main_key = config.main_key
  command("HastenMapBuf", function(args)
    local sub_key = args.fargs[1]
    local curr_bufnr = utils.get_current_bufnr()

    if curr_bufnr == nil then
      logger.info("Current buffer is empty.")
      return
    end

    if sub_key == nil then
      return
    elseif #sub_key > 1 then
      logger.info("Should be only one sub key!")
      return
    end

    local remap = utils._map_current_buffer(main_key, sub_key)

    keymap.set("n", remap, function() utils.set_current_bufnr(curr_bufnr) end, { silent = true })
    M._maps[remap] = vim.fn.expand("%")
  end, default_opts)

  command("HastenViewMaps", function()
    if M._view_maps == false then
      M._view_maps = true
      utils.show_remaps(M._maps)
    else
      M._view_maps = false
      utils.close_remaps()
    end
  end, default_opts)

  command("HastenClearMaps", function()
    for k, _ in pairs(M._maps) do
      local _, err = pcall(function()
        keymap.del("n", k)
      end)
      if err ~= nil then
        logger.error("Error deleting keymaps!")
      end
    end
    for _, m in pairs(default_maps) do
      local rhs = m.rhs
      if rhs == nil then
        rhs = function()
          m.callback()
        end
      end
      keymap.set("n", m.lhs, rhs)
    end
    M._user_defined_maps = config.predefined_keymaps
  end, default_opts)

  command("HastenUsePredefinedMaps", function()
    if utils._table_len(M._user_defined_maps) == 0 then
      logger.warn("Not enough user defined maps provided.")
      return
    end

    local pd_map = table.remove(M._user_defined_maps, 1)
    local curr_bufnr = utils.get_current_bufnr()

    keymap.set("n", pd_map, function()
      utils.set_current_bufnr(curr_bufnr)
    end, { silent = true })
    M._maps[pd_map] = vim.fn.expand("%")
  end, default_opts)
end

return M
