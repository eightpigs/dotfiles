local nvim_lsp = require 'nvim_lsp'
local lsp = vim.lsp

local _web_config = {
  root_dir = nvim_lsp.util.root_pattern('.git', 'package.json');
}

local servers = {
  {name = 'bashls'},
  {name = 'vimls'},
  {name = 'jsonls'},
  {name = 'sumneko_lua'},
  {name = 'yamlls'},
  {
    name = 'vuels',
    config = _web_config
  },
  {
    name = 'cssls',
    config = _web_config
  },
  {
    name = 'html',
    config = _web_config
  },
  {
    name = 'gopls',
    config = {
      root_dir = nvim_lsp.util.root_pattern("go.mod", ".git");
    }
  },
  {name = 'pyls'},
  {
    name = 'rust_analyzer',
    root_dir = nvim_lsp.util.root_pattern('Cargo.toml', 'rust-project.json', '.git');
    settings = {
      ["rust-analyzer"] = {}
    }
  },
  {
    name = "jdtls",
    config = {
      root_dir = nvim_lsp.util.root_pattern("pom.xml", "settings.gradle", "gradle.properties", "build.gradle", ".git");
      init_options = {
        jvm_args = {},
        -- workspace = "~/workspace/java"
      }
    }
  },
  {
    name = "dartls",
    config = {
      root_dir = nvim_lsp.util.root_pattern('.git', '.pubspec.yaml');
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
  nvim_lsp[server.name].setup(config)
end
