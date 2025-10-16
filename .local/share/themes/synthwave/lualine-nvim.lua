-- local colors = {
-- 	black = "#141425",
-- 	blue = "#80a0ff",
-- 	green = "#9ece6a",
-- 	yellow = "#e0af68",
-- 	red = "#ff5189",
-- 	purple = "#ad8ee6",
-- 	violet = "#d183e8",
-- 	amethyst = "#9966cc",
-- 	magenta = "#FF00FF",
-- 	grey = "#303030",
-- 	bg_gutter = "#443454",
-- 	fg_statusline = "#a9b1d6",
-- 	bg_statusline = "#322333",
-- 	fg_sidebar = "#a9b1d6",
-- }

-- local purple_rain = {

-- 	normal = {
-- 		a = { bg = colors.purple, fg = colors.black },
-- 		b = { bg = colors.bg_gutter, fg = colors.purple },
-- 		c = { bg = colors.bg_statusline, fg = colors.fg_sidebar },
-- 	},

-- 	insert = {
-- 		a = { bg = colors.violet, fg = colors.black },
-- 		b = { bg = colors.bg_gutter, fg = colors.violet },
-- 	},

-- 	command = {
-- 		a = { bg = colors.amethyst, fg = colors.black },
-- 		b = { bg = colors.bg_gutter, fg = colors.amethyst },
-- 	},

-- 	visual = {
-- 		a = { bg = colors.magenta, fg = colors.black },
-- 		b = { bg = colors.bg_gutter, fg = colors.magenta },
-- 	},

-- 	replace = {
-- 		a = { bg = colors.red, fg = colors.black },
-- 		b = { bg = colors.bg_gutter, fg = colors.red },
-- 	},

-- 	inactive = {
-- 		a = { bg = colors.bg_statusline, fg = colors.blue },
-- 		b = { bg = colors.bg_statusline, fg = colors.bg_gutter, gui = "bold" },
-- 		c = { bg = colors.bg_statusline, fg = colors.bg_gutter },
-- 	},
-- }



local colors = {
	black = "#000000",
	deep_black = "#0a0a0a",
	blue = "#00ccff",
	green = "#00ff88",
	yellow = "#ffff00",
	red = "#ff0066",
	
	-- Electric purples/magentas/pinks
	neon_purple = "#aa00ff",
	electric_purple = "#cc00ff", 
	cyber_purple = "#9900ff",
	plasma_purple = "#bb00ff",
	
	electric_magenta = "#ff00ff",
	neon_magenta = "#ff00cc",
	cyber_magenta = "#ee00ee",
	bright_magenta = "#ff33ff",
	
	hot_pink = "#ff0099",
	neon_pink = "#ff0080",
	electric_pink = "#ff1493",
	cyber_pink = "#ff00aa",
	
	synthwave_violet = "#dd00ff",
	laser_violet = "#cc33ff",
	
	-- Vibrant backgrounds
	dark_purple = "#220044",
	dark_magenta = "#440044", 
	dark_pink = "#330022",
	grey_purple = "#441166",
	grey_magenta = "#442255",
	
	-- Bright text
	purple_white = "#ffeeff",
	magenta_white = "#ffeeff",
	pink_white = "#ffddff",
	light_purple = "#ddbbff",
	light_magenta = "#ffbbff",
}

local purple_rain = {

	normal = {
		a = { bg = colors.electric_purple, fg = colors.purple_white, gui = "bold" },
		b = { bg = colors.grey_purple, fg = colors.neon_purple },
		c = { bg = colors.dark_purple, fg = colors.light_purple },
	},

	insert = {
		a = { bg = colors.synthwave_violet, fg = colors.magenta_white, gui = "bold" },
		b = { bg = colors.grey_magenta, fg = colors.laser_violet },
		c = { bg = colors.dark_magenta, fg = colors.light_magenta },
	},

	command = {
		a = { bg = colors.cyber_purple, fg = colors.purple_white, gui = "bold" },
		b = { bg = colors.grey_purple, fg = colors.plasma_purple },
		c = { bg = colors.dark_purple, fg = colors.light_purple },
	},

	visual = {
		a = { bg = colors.electric_magenta, fg = colors.black, gui = "bold" },
		b = { bg = colors.grey_magenta, fg = colors.bright_magenta },
		c = { bg = colors.dark_magenta, fg = colors.light_magenta },
	},

	replace = {
		a = { bg = colors.hot_pink, fg = colors.pink_white, gui = "bold" },
		b = { bg = colors.grey_magenta, fg = colors.electric_pink },
		c = { bg = colors.dark_pink, fg = colors.light_magenta },
	},

	terminal = {
		a = { bg = colors.neon_magenta, fg = colors.black, gui = "bold" },
		b = { bg = colors.grey_magenta, fg = colors.cyber_magenta },
		c = { bg = colors.dark_magenta, fg = colors.light_magenta },
	},

	select = {
		a = { bg = colors.cyber_pink, fg = colors.pink_white, gui = "bold" },
		b = { bg = colors.grey_purple, fg = colors.neon_pink },
		c = { bg = colors.dark_pink, fg = colors.light_purple },
	},

	inactive = {
		a = { bg = colors.grey_purple, fg = colors.light_purple },
		b = { bg = colors.dark_purple, fg = colors.light_magenta },
		c = { bg = colors.deep_black, fg = colors.light_purple },
	},
}






local config = function()
	-- local theme = require("lualine.themes.horizon")
	-- theme.normal.c.bg = nil

	require("lualine").setup({
		options = {
			theme = purple_rain,
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
