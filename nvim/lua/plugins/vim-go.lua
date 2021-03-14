local g = vim.g
local command = vim.api.nvim_command


-----------------------------
-- Properties
-----------------------------

g.go_def_mapping_enabled = 0
g.go_highlight_fields = 0
g.go_highlight_functions = 0
g.go_highlight_function_calls = 0
g.go_highlight_extra_types = 0
g.go_highlight_operators = 0
g.go_fmt_autosave = 1
g.go_fmt_command = "goimports"
g.go_auto_type_info = 1
g.go_version_warning = 1
g.go_code_completion_enabled = 0
g.go_code_completion_icase = 0
g.go_info_mode = 'gopls'
g.go_auto_sameids = 0
g.go_updatetime = 500
g.go_imports_autosave = 1
g.go_imports_mode = "gopls"
g.go_doc_popup_window = 1
g.go_def_mode = 'gopls'
g.go_debug_mapping = {{}}

command [[
hi GoDebugBreakpoint guifg=Black guibg=#BAD4F5
hi GoDebugCurrent guifg=white guibg=#fb4934
]]
