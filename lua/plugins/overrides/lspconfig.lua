return {
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()

    local lspconfig = require "lspconfig"
    local on_init = require("nvchad.configs.lspconfig").on_init
    local capabilities = require("nvchad.configs.lspconfig").capabilities
    local on_attach = require("nvchad.configs.lspconfig").on_attach

    -- 需要配置的lsp servers
    local servers = {
      "bashls",
      "clangd",
      "cssls",
      "html",
      "gopls",
      "jsonls",
      "marksman",
      "pyright",
      "rust_analyzer",
      "taplo",
      "yamlls",
    }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    end

    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      on_init = on_init,
      settings = {
        Lua = {
          hint = { enable = true },
          telemetry = { enable = true },
          diagnostics = { globals = { "bit", "vim", "it", "describe", "before_each", "after_each" } },
        },
      },
    }
  end,
}
