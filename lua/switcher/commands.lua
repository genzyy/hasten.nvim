local utils = require("switcher.utils")
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

--- @param config SwitcherConfig
M.create_user_commands = function(config, default_maps)
  local main_key = config.main_key
  command("MapCurrBuf", function(args)
    local sub_key = args.fargs[1]
    local curr_bufnr = utils.get_current_bufnr()

    if curr_bufnr == nil then
      print(vim.inspect("Current buffer is empty."))
      return
    end

    if sub_key == nil then
      return
    end

    local remap = utils._map_current_buffer(main_key, sub_key)

    print(vim.inspect(default_maps))

    keymap.set("n", remap, function() utils.set_current_bufnr(curr_bufnr) end, { silent = true })
    M._maps[remap] = vim.fn.expand("%")
  end, default_opts)

  command("ToggleViewMaps", function()
    if M._view_maps == false then
      M._view_maps = true
      utils.show_remaps(M._maps)
    else
      M._view_maps = false
      utils.close_remaps()
    end
  end, default_opts)

  command("ClearMaps", function()
    for k, _ in pairs(M._maps) do
      local _, err = pcall(function()
        keymap.del("n", k)
      end)
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
  end, default_opts)
end

return M
