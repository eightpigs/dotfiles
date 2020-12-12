local lspconfig = require 'lspconfig'
local lsp = vim.lsp

local servers = {
  {name = 'bashls'},
  {name = 'vimls'},
  {name = 'jsonls'},
  {name = 'sumneko_lua'},
  {name = 'yamlls'},
  {
    name = 'vuels',
    config = {
      root_dir = lspconfig.util.root_pattern("package.json", '.eslintrc.js', ".git"),
      filetypes = { "vue", "javascript" }
    }
  },
  {
    name = 'cssls',
    config = {
      root_dir = lspconfig.util.root_pattern('.git', 'package.json')
    }
  },
  {
    name = 'html',
    config = {
      root_dir = lspconfig.util.root_pattern('.git', 'package.json'),
      filetypes = { "html" },
      configurationSection = { "html"},
      embeddedLanguages = {
        css = false,
        javascript = false
      }
    }
  },
  {
    name = 'gopls',
    config = {
      root_dir = lspconfig.util.root_pattern("go.mod", ".git");
    }
  },
  {name = 'pyls'},
  {
    name = 'rust_analyzer',
    config = {
      root_dir = lspconfig.util.root_pattern('Cargo.toml', 'rust-project.json', '.git');
      settings = {
        ["rust-analyzer"] = {}
      }
    }
  },
  {
    name = "jdtls",
    config = {
      root_dir = lspconfig.util.root_pattern(".project", "pom.xml", "settings.gradle", "gradle.properties", "build.gradle", ".git");
      init_options = {
        jvm_args = {},
        workspace = "/Users/eightpigs/Workspace/java/"
      }
    }
  },
  {
    name = "dartls",
    config = {
      root_dir = lspconfig.util.root_pattern('.git', '.pubspec.yaml');
      init_options = {
        closingLabels = "true",
        flutterOutline = "true",
        onlyAnalyzeProjectsWithOpenFiles = "false",
        outline = "true",
        suggestFromUnimportedLibraries = "true",
        allowAnalytics = "false",
        flutterHotReloadOnSave = "true",
        flutterHotRestartOnSave = "true",
        flutterScreenshotPath = "~/Documents/",
        lineLength = "120",
      }
    }
  }
}

for _, server in ipairs(servers) do
  local config = server.config or {}
  lspconfig[server.name].setup(config)
end
