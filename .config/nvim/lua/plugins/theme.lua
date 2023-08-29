return {
  {
    "RRethy/nvim-base16",
    name = "nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "base16-ocean"
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
  },
}
