return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  init = function()
    vim.keymap.set("n", "<leader>fm", function()
      require("conform").format { lsp_fallback = true }
    end, { desc = "Format files" })
  end,
  opts = {
    formatters_by_ft = {
      bash = { "shfmt" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      json = { "biome" },
      lua = { "stylua" },
      toml = { "taplo" },
      yaml = { "yamlfmt" },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters = {
      yamlfmt = { "-formatter", "retain_line_breaks_single=true" },
    },
  },
}
