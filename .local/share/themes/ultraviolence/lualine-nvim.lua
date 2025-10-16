local colors = {
	black = "#000000",
	deep_black = "#0a0a0a",
	
	neon_red = "#ff0033",
	laser_red = "#ff0066",
	cyber_red = "#ff0040",
	plasma_red = "#ff1155",
	electric_crimson = "#ee1144",
	bright_red = "#ff2244",
	fire_red = "#ff0022",
	deep_crimson = "#cc0022",
	
	hot_pink = "#ff1493",
	neon_pink = "#ff0080",
	electric_pink = "#ff0099",
	cyber_pink = "#ff0066",
	plasma_pink = "#ff1188",
	rose_pink = "#ff3366",
	bright_pink = "#ff4488",
	
	dark_red = "#220000",
	dark_pink = "#330011",
	grey_red = "#440022",
	grey_pink = "#330022",
	deep_red = "#110000",
	
	red_white = "#ffdddd",
	pink_white = "#ffeeee",
	rose_white = "#ffe6e6",
	light_red = "#ffcccc",
	light_pink = "#ffddee",
	bright_red_text = "#ff99aa",
	bright_pink_text = "#ff99bb",
}

local cyber_meltdown = {
	normal = {
		a = { bg = colors.fire_red, fg = colors.black, gui = "bold" },
		b = { bg = colors.grey_red, fg = colors.plasma_red },
		c = { bg = colors.dark_red, fg = colors.light_red },
	},

	insert = {
		a = { bg = colors.bright_pink, fg = colors.black, gui = "bold" },
		b = { bg = colors.grey_pink, fg = colors.bright_red },
		c = { bg = colors.dark_pink, fg = colors.light_pink },
	},

	command = {
		a = { bg = colors.deep_crimson, fg = colors.rose_white, gui = "bold" },
		b = { bg = colors.grey_pink, fg = colors.electric_pink },
		c = { bg = colors.dark_pink, fg = colors.light_pink },
	},

	visual = {
		a = { bg = colors.neon_pink, fg = colors.black, gui = "bold" },
		b = { bg = colors.grey_red, fg = colors.fire_red },
		c = { bg = colors.dark_red, fg = colors.bright_red_text },
	},

	replace = {
		a = { bg = colors.laser_red, fg = colors.pink_white, gui = "bold" },
		b = { bg = colors.grey_pink, fg = colors.cyber_pink },
		c = { bg = colors.dark_pink, fg = colors.bright_pink_text },
	},

	terminal = {
		a = { bg = colors.hot_pink, fg = colors.black, gui = "bold" },
		b = { bg = colors.grey_red, fg = colors.electric_crimson },
		c = { bg = colors.dark_red, fg = colors.light_red },
	},

	select = {
		a = { bg = colors.electric_crimson, fg = colors.black, gui = "bold" },
		b = { bg = colors.grey_pink, fg = colors.neon_pink },
		c = { bg = colors.dark_pink, fg = colors.light_pink },
	},

	inactive = {
		a = { bg = colors.grey_red, fg = colors.bright_red_text },
		b = { bg = colors.dark_red, fg = colors.light_red },
		c = { bg = colors.deep_black, fg = colors.light_red },
	},
}





local config = function()
	-- local theme = require("lualine.themes.horizon")
	-- theme.normal.c.bg = nil

	require("lualine").setup({
		options = {
			theme = cyber_meltdown,
			globalstatus = true,
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "buffers" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		tabline = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
