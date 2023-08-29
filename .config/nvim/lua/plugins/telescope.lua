return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find Plugin File",
			},
			{
				"<leader>fw",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Find File",
			},
			{
				"<leader>fh",
        "<cmd>Telescope harpoon marks<cr>",
				desc = "Find harpoon",
			},
			{
				"<leader>fb",
        "<cmd>Telescope buffers<cr>",
				desc = "Find buffer",
			},
		},
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
				require("telescope").load_extension("harpoon")
			end,
		},
	},
}
