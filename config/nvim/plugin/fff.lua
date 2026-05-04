vim.pack.add({
	{ src = "https://github.com/dmtrKovalenko/fff.nvim" },
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "fff.nvim" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("fff.nvim")
			end

			require("fff.download").download_or_build_binary()
		end
	end,
})

vim.g.fff = {
	lazy_sync = true,
	title = "Find Files",
}

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		require("fff.download").ensure_downloaded({}, function(download_ok)
			if download_ok then
				return
			end

			require("fff.download").build_binary(function(build_ok, build_err)
				if build_ok then
					vim.schedule(function()
						vim.notify("fff.nvim backend built. Restart Neovim to use it.", vim.log.levels.INFO)
					end)
					return
				end

				vim.schedule(function()
					vim.notify("fff.nvim backend build failed: " .. (build_err or "unknown error"), vim.log.levels.ERROR)
				end)
			end)
		end)
	end,
})
