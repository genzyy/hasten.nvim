local notify = vim.notify
local LOG_LEVEL = vim.log.levels

--- @class Logger
--- @field info_lvl integer?
--- @field warn_lvl integer?
--- @field err_lvl integer?
local Logger = {}

--- @param info_lvl integer?
--- @param warn_lvl integer?
--- @param err_lvl integer?
function Logger:new(info_lvl, warn_lvl, err_lvl)
  local logger = setmetatable({
    info_lvl = info_lvl or LOG_LEVEL.INFO,
    warn_lvl = warn_lvl or LOG_LEVEL.WARN,
    err_lvl = err_lvl or LOG_LEVEL.ERROR,
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
