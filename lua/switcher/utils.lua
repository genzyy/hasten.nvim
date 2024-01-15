local ui = require("switcher.ui")
local vim_api = vim.api
local utils = {}

--- @return integer
utils.get_current_bufnr = function()
    return vim_api.nvim_get_current_buf()
end

--- @param bufnr integer
utils.set_current_bufnr = function(bufnr)
    vim.api.nvim_set_current_buf(bufnr)
end

--- @param maps table
utils.show_remaps = function(maps)
    local contents = {}
    for key, value in pairs(maps) do
        local line = key .. " => " .. value
        table.insert(contents, line)
    end

    local popup_cb = function(_, _sel) end

    local bufnr = ui.show_window({}, popup_cb)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
end

utils.close_remaps = function()
    ui.close_window()
end

return utils
