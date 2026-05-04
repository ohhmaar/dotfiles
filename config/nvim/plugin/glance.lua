vim.pack.add({
	{ src = "https://github.com/DNLHC/glance.nvim" },
})

local glance = require("glance")

glance.setup({
	hooks = {
		before_open = function(results, open, jump)
			if #results == 1 then
				jump(results[1])
				return
			end

			open(results)
		end,
	},
})
