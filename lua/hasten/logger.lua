local notify = vim.notify
local LOG_LEVEL = vim.log.levels

--- @class Logger
--- @field info_lvl integer?
--- @field warn_lvl integer?
--- @field err_lvl integer?
local Logger = {}

function Logger:new()
  local logger = setmetatable({
    info_lvl = LOG_LEVEL.INFO,
    warn_lvl = LOG_LEVEL.WARN,
    err_lvl = LOG_LEVEL.ERROR,
  }, self)

  return logger
end

--- @param message string
function Logger:info(message) notify(message, self.info_lvl) end

--- @param message string
function Logger:warn(message) notify(message, self.warn_lvl) end

--- @param message string
function Logger:error(message) notify(message, self.err_lvl) end

return Logger
