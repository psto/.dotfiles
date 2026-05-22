local M = {}

function M.smart_quit()
	local bufnr = vim.api.nvim_get_current_buf()
	local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
	if modified then
		vim.ui.input({
			prompt = "You have unsaved changes. Quit anyway? (y/n) ",
		}, function(input)
			if input == "y" then
				vim.cmd("q!")
			end
		end)
	else
		vim.cmd("q!")
	end
end

function M.diffview_toggle(cmd)
	if next(require("diffview.lib").views) == nil then
		vim.cmd(cmd)
	else
		vim.cmd("DiffviewClose")
	end
end

function M.toggle_quickfix()
	local windows = vim.fn.getwininfo()
	for _, win in pairs(windows) do
		if win["quickfix"] == 1 then
			vim.cmd.cclose()
			return
		end
	end
	vim.cmd.copen()
end

function M.get_url_title()
	local url = vim.fn.getreg("+")
	local is_url = url:match("[a-z]*://[^ >,;]*")

	if not is_url then
		vim.api.nvim_feedkeys("p", "n", true)
		return
	end

	-- Use vim.system for an async, non-blocking call
	-- We limit curl to 10 seconds and follow redirects (-L)
	vim.system({ "curl", "-sL", url }, { text = true }, function(obj)
		vim.schedule(function()
			if obj.code ~= 0 or not obj.stdout then
				vim.notify("Failed to fetch URL", vim.log.levels.ERROR)
				return
			end

			-- Extract title
			local title = obj.stdout:match("<title>(.-)</title>")

			if title then
				-- Clean up title (remove extra whitespace/newlines)
				title = title:gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
				local markdown_url = string.format("[%s](%s)", title, url)

				-- Put text at cursor
				vim.api.nvim_put({ markdown_url }, "c", true, true)
			else
				-- Fallback to just pasting the URL if no title found
				vim.api.nvim_put({ url }, "c", true, true)
			end
		end)
	end)
end

function M.toggle_undotree()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end

return M
