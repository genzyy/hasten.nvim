local notify = vim.notify
local LOG_LEVEL = vim.log.levels

local Logger = {}

--- @param message string
function Logger.info(message)
  notify(message, LOG_LEVEL.INFO)
end

--- @param message string
function Logger.warn(message)
  notify(message, LOG_LEVEL.WARN)
end

--- @param message string
function Logger.error(message)
  notify(message, LOG_LEVEL.ERROR)
end

return Logger
