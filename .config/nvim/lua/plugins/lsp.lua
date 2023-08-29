return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    lazy = true,
    config = function()
      require("lsp-zero.settings").preset({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      require("lsp-zero.cmp").extend()
      local cmp = require("cmp")
      local cmp_action = require("lsp-zero.cmp").action()

      cmp.setup({
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "williamboman/mason.nvim" },
    },
    config = function()
      local lsp = require("lsp-zero")

      lsp.ensure_installed(
        {
          "pylsp",
          "ruff_lsp",
          "gopls",
        }
      )

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      nvim_lsp = require("lspconfig")
      nvim_lsp.lua_ls.setup(lsp.nvim_lua_ls())
      nvim_lsp.ruff_lsp.setup({})
      nvim_lsp.gopls.setup({})
      nvim_lsp.dartls.setup({})
      nvim_lsp.pylsp.setup({})

      lsp.setup()
    end,
  },
}
