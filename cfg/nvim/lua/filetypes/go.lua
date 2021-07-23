local actions = require 'actions'

local _dict = {}

_dict['run.start'] = function() vim.cmd ':GoRun' end
_dict['run.restart'] = function() end
_dict['run.stop'] = function() end
_dict['debug.start'] = function() vim.cmd ':GoDebugStart' end
_dict['debug.stop'] = function() vim.cmd ':GoDebugStop' end
_dict['debug.breakpoint'] = function() vim.cmd ':GoDebugBreakpoint' end
_dict['debug.continue'] = function() vim.cmd ':GoDebugContinue' end
_dict['debug.next'] = function() vim.cmd ':GoDebugNext' end
_dict['debug.step'] = function() vim.cmd ':GoDebugStep' end
_dict['debug.stepOut'] = function() vim.cmd ':GoDebugStepOut' end

actions.registerMulti('go', _dict)
