local g = vim.g
local command = vim.api.nvim_command


-----------------------------
-- Properties
-----------------------------

g.go_def_mapping_enabled = 0
g.go_highlight_fields = 1
g.go_highlight_functions = 1
g.go_highlight_function_calls = 1
g.go_highlight_extra_types = 1
g.go_highlight_operators = 1
g.go_fmt_autosave = 1
g.go_fmt_command = "goimports"
g.go_auto_type_info = 1
g.go_version_warning = 1
g.go_code_completion_enabled = 0
g.go_code_completion_icase = 0
g.go_info_mode = 'gopls'
g.go_auto_sameids = 1
g.go_updatetime = 500
g.go_imports_autosave = 1
g.go_imports_mode = "gopls"
g.go_doc_popup_window = 1
g.go_def_mode = 'gopls'
