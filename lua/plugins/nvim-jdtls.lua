return {
  {
    "mfussenegger/nvim-jdtls",
    ---@type lspconfig.options.jdtls
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      jdtls = function(opts)
        local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
        local jvmArg = "-javaagent:" .. install_path .. "/lombok.jar"
        table.insert(opts.cmd, "--jvm-arg=" .. jvmArg)
        opts.on_attach = function(client, bufnr)
          client.server_capabilities.documentFronmattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          vim.cmd([[autocmd BufWritePre *.java lua vim.lsp.buf.format({ timeout_ms = 1000 })]])
        end

        opts.settings = {
          java = {
            format = {
              enabled = true,
            },
          },
        }

        return opts
      end,
    },
  },
}
