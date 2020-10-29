-------------------------------------------------------------------------------
-- vim-rooter
-------------------------------------------------------------------------------

local g = vim.g


-----------------------------
-- Properties
-----------------------------

g.rooter_patterns = {'.git', '.svn/', '.idea/', 'package.json', '_darcs/', '.hg/', '.bzr/'}
g.rooter_change_directory_for_non_project_files = ''
g.rooter_silent_chdir = 1
