local nvim_lsp = require 'nvim_lsp'

-- bash
require'nvim_lsp'.bashls.setup{}

-- vim
require'nvim_lsp'.vimls.setup{}

-- json
require'nvim_lsp'.jsonls.setup{}

-- lua
require'nvim_lsp'.sumneko_lua.setup{}

-- yaml
require'nvim_lsp'.yamlls.setup{}

local web_root_dir = nvim_lsp.util.root_pattern('.git', 'package.json');

-- vue
require'nvim_lsp'.vuels.setup{
  root_dir = web_root_dir;
}

-- css
require'nvim_lsp'.cssls.setup{
  root_dir = web_root_dir;
}

-- html
require'nvim_lsp'.html.setup{
  root_dir = web_root_dir;
}

-- gopls
require'nvim_lsp'.gopls.setup{
  root_dir = nvim_lsp.util.root_pattern("go.mod", ".git");
}

-- python
require'nvim_lsp'.pyls.setup{}


-- rust
require'nvim_lsp'.rust_analyzer.setup{
  root_dir = nvim_lsp.util.root_pattern('Cargo.toml', 'rust-project.json', '.git');
  settings = {
    ["rust-analyzer"] = {}
  }
}

-- java
require'nvim_lsp'.jdtls.setup{
  root_dir = nvim_lsp.util.root_pattern("pom.xml", "settings.gradle", "gradle.properties", "build.gradle", ".git");
  init_options = {
    jvm_args = {},
    workspace = "~/workspace/java"
  }
}

-- dart
require'nvim_lsp'.dartls.setup{
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
