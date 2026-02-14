return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo", "Format" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
      },
      format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "lua" and vim.fn.executable("stylua") == 1 then
          return {
            timeout_ms = 2000,
            lsp_fallback = true,
          }
        end
        if ft == "nix" and vim.fn.executable("nixfmt") == 1 then
          return {
            timeout_ms = 2000,
            lsp_fallback = true,
          }
        end
        return nil
      end,
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)

      vim.api.nvim_create_user_command("Format", function()
        local ok, err = pcall(function()
          conform.format({ async = false, lsp_fallback = true, timeout_ms = 2000 })
        end)
        if not ok then
          vim.notify("Format failed: " .. tostring(err), vim.log.levels.WARN)
        end
      end, { desc = "Format current buffer" })
    end,
  },
}
