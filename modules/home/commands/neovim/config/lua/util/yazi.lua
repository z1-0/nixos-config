local PATH_CHOOSE_FILES = "/tmp/00000000"

local M = setmetatable({}, {
	__call = function(m, ...)
		return m.open(...)
	end,
})

function M.open(cwd)
	vim.fn.delete(PATH_CHOOSE_FILES)

	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		once = true,
		callback = function()
			-- vim.cmd.startinsert()
			vim.api.nvim_feedkeys("i", "n", true)
		end,
	})

	local cmd = { "yazi", cwd, "--chooser-file", PATH_CHOOSE_FILES }

	LazyVim.terminal(cmd, {
		on_exit = function(_, code, _)
			if code ~= 0 then
				return
			end

			if vim.fn.filereadable(PATH_CHOOSE_FILES) ~= 1 then
				return
			end

			local choose_files = vim.fn.readfile(PATH_CHOOSE_FILES)
			local directories = {}

			for _, path in ipairs(choose_files) do
				if vim.fn.isdirectory(path) == 1 then
					table.insert(directories, path)
				else
					vim.cmd(string.format("edit %s", path))
				end
			end

			local _, first_dir = next(directories)
			if first_dir ~= nil then
				M.open(first_dir)
			end
		end,
	})
end

return M
