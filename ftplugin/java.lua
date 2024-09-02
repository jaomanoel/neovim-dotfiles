-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/joaomanoel/Documents/" .. project_name

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    --"/usr/lib/jvm/java-17-openjdk-17.0.9.0.9-3.fc39.x86_64", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    --"-Declipse.application=org.eclipse.jdt.ls.core.id1",
    --    "-Dosgi.bundles.defaultStartLevel=4",
    --    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    --"-dlog.protocol=true",
    --"-dlog.level=all",
    --"-xmx1g",
    --"--add-modules=all-system",
    --"--add-opens",
    --"java.base/java.util=all-unnamed",
    --"--add-opens",
    --"java.base/java.lang=all-unnamed",

    -- 💀
    --"-jar",
    --"/path/to/jdtls_install_location/plugins/org.eclipse.equinox.v1.30.0.jar",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- must point to the                                                     change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    --"-configuration",
    --"/home/joaomanoel/jdtls/config_linux",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- must point to the                      change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            depending on your system.

    -- 💀
    -- see `data directory configuration` section in the readme
    "-data",
    workspace_dir,
  },

  -- 💀
  -- this is the default if not provided, you can remove it. or adjust as needed.
  -- one dedicated lsp server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

  -- here you can configure eclipse.jdt.ls specific settings
  -- see https://github.com/eclipse/eclipse.jdt.ls/wiki/running-the-java-ls-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.springframework.security.config.Customizer.withDefaults",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}1{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      configuration = {
        runtimes = {
          {
            name = "java-17-openjdk",
            path = "/usr/lib/jvm/java-17-openjdk",
            default = true,
          },
          {
            name = "jre-17",
            path = "/usr/lib/jvm/jre-17",
            default = false,
          },
        },
      },
    },
  },

  -- language server `initializationoptions`
  -- you need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- see https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- if you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
  on_attach = function(client, bufnr)
    -- Desabilita validação contínua
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Desabilita a verificação automática
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

    -- Configura validação ao salvar
    vim.cmd([[autocmd BufWritePre *.java lua vim.lsp.buf.format({ timeout_ms = 1000 })]])
    vim.cmd([[autocmd BufWritePre *.java lua vim.lsp.buf.code_action()]])
    vim.cmd([[autocmd BufWritePre *.java lua vim.lsp.buf.execute_command({ command = "java.action.organizeImports" })]])
  end,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
