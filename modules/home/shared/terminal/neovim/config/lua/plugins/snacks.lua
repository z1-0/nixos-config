return {
	{
		"snacks.nvim",
		opts = {
			dashboard = {
				formats = {
					key = function(item)
						return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
					end,
				},
				sections = {
					{ section = "terminal", cmd = "pipes.sh", padding = 2 },
					{ section = "recent_files", limit = 8, padding = 1 },
					{ section = "projects", limit = 8, padding = 1 },
					{ section = "keys", padding = 1 },
					{ section = "startup" },
				},
			},
		},
	},
}
