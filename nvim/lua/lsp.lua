local lspconfig = require 'lspconfig'
local sign_define = vim.fn.sign_define
local command = vim.api.nvim_command
local fn = vim.fn
local lsp = vim.lsp
local b = vim.b
local M = {}

local _home = os.getenv('HOME')

sign_define(
  "LspDiagnosticsErrorSign",
  {
    text = "x",
    texthl = "LspDiagnosticsError",
    linehl = "",
    numhl = ""
  }
)
sign_define(
  "LspDiagnosticsWarningSign",
  {
    text = "!",
    texthl = "LspDiagnosticsWarning",
    linehl = "",
    numhl = ""
  }
)
sign_define(
  "LspDiagnosticsInformationSign",
  {
    text = "I",
    texthl = "LspDiagnosticsInformation",
    linehl = "",
    numhl = ""
  }
)
sign_define(
  "LspDiagnosticsHintSign",
  {
    text = ">",
    texthl = "LspDiagnosticsHint",
    linehl = "",
    numhl = ""
  }
)

function initServers()
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
      }
    },
    {
      name = "jdtls",
      config = {
        root_dir = lspconfig.util.root_pattern(".project", "pom.xml", "settings.gradle", "gradle.properties", "build.gradle", ".git");
        init_options = {
          jvm_args = {},
          workspace = _home.."/Workspace/java/"
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
end

function M.currentLSPServer()
  local bufnr = fn.bufnr('%')
  local name_str = ''
  if lsp.buf.server_ready() then
    local clients = lsp.buf_get_clients(bufnr)
    if clients ~= nil then
      for _, client in pairs(clients) do
        name_str = client["name"]
        break
      end
    end
  end
  return name_str
end

initServers()

command("command LSPServer :lua print(require'lsp'.currentLSPServer())")

return M
