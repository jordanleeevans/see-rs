local current_mode = vim.fn.mode()
local current_file = vim.api.nvim_buf_get_name(0)

local augroup = vim.api.nvim_create_augroup("seers_capture", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
	group = augroup,
	callback = function()
		current_mode = vim.v.event.new_mode
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	callback = function(ev)
		current_file = vim.api.nvim_buf_get_name(ev.buf)
	end,
})

vim.on_key(function(key)
	local event = {
		key = vim.fn.keytrans(key),
		mode = current_mode,
		file = current_file,
	}
	vim.rpcnotify(0, "seers_key_event", event)
end)
