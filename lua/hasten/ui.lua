local popup = require("plenary.popup")
local ui = {}

ui.win = nil
ui.win_config = {
  height = 15,
  width = 90,
  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}

--- @param opts table
--- @param cb function
--- @param custom_title string?
--- @return integer
ui.show_window = function(opts, cb, custom_title)
  ui.win = popup.create(opts, {
    title = custom_title or "Hasten",
    highlight = "Hastenpopup",
    line = math.floor(((vim.o.lines - ui.win_config.height) / 2) - 1),
    col = math.floor((vim.o.columns - ui.win_config.width) / 2),
    minheight = ui.win_config.height,
    minwidth = ui.win_config.width,
    borderchars = ui.win_config.borderchars,
    callback = cb,
  })

  local bufnr = vim.api.nvim_win_get_buf(ui.win)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":HastenViewMaps<CR>", { silent = true })

  return bufnr
end

ui.close_window = function()
  if ui.win == nil then
    return
  end
  vim.api.nvim_win_close(ui.win, true)
end

return ui
