local commands = require("hasten.commands")
local utils = require("hasten.utils")
local M = {}

--- @class HastenConfig
--- @field main_key "control" | "alt" |  "leader"
--- @field window_properties table
local switcher_config = {
  main_key = "control",
  window_properties = {
    --- @type integer
    width = 30,
    --- @type integer
    height = 60,
  }
}

local default_maps = vim.api.nvim_get_keymap("n")

--- @param cfg HastenConfig
M.setup = function(cfg)
  if cfg == nil then
    print(vim.inspect("print set main key for hasten to work."))
    return
  end

  if cfg.main_key == nil or cfg == {} then
    cfg = utils._extend(switcher_config, cfg)
  end
  commands.create_user_commands(cfg, default_maps)
end

return M
