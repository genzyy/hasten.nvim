local commands = require("switcher.commands")
local M = {}

--- @param cfg table
M.setup = function(cfg)
  if cfg == nil then
    print(vim.inspect("print set main key for switcher to work."))
    return
  end
  if cfg.main_key == nil then
    cfg.main_key = "<leader>" -- use leader as main key by default
  end
  commands.create_user_commands(cfg.main_key)
end

return M
