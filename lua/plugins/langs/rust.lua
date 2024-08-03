return {
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function(_, opts)
      local crates = require "crates"
      local cmp = require "cmp"

      crates.setup(opts)

      cmp.setup.buffer {
        sources = { { name = "crates" } },
      }

      crates.show()

      vim.keymap.set("n", "<leader>cu", function()
        crates.upgrade_all_crates()
      end, { desc = "Update crates" })
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = {
            border = "rounded",
          },
        },
        -- lsp 配置
        server = {
          on_attach = function()
            vim.lsp.inlay_hint.enable()
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true,
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                },
              },
            },
          },
          dap = {},
        },
      }

      local map = vim.keymap.set
      map("n", "K", "<cmd>lua vim.cmd.RustLsp({ 'hover', 'actions' })<CR>", { desc = "Rust Hover" })
      map("n", "<leader>ca", "<cmd>lua vim.cmd.RustLsp('codeAction')<CR>", { desc = "Rust Code actions" })
    end,
  },
}
