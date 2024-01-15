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

--- @param main_key string
M.create_user_commands = function(main_key)
	command("MapCurrBuf", function(args)
		local mapped_key = args.fargs[1]
		local curr_bufnr = utils.get_current_bufnr()

		print(vim.inspect(vim.fn.expand("%")))

		if curr_bufnr == nil then
			print(vim.inspect("Current buffer is empty."))
			return
		end

		if mapped_key == nil then
			return
		end

		local remap = main_key .. mapped_key

		keymap.set("n", remap, function()
			utils.set_current_bufnr(curr_bufnr)
		end, { silent = true })
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
end

return M
