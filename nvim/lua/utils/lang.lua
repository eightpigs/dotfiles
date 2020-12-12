local M = {}
function M.itob(val)
  if val ~= nil and val > 0 then
    return true
  else
    return false
  end
end

function M.format(str, placehoders, targets)
  if str == nil or placehoders == nil or #placehoders == 0
     or targets == nil or #placehoders ~= #targets then
    return ''
  end
  local result = str
  for i = 1, #placehoders do
    result = result:gsub(placehoders[i], targets[i])
  end
  return result
end


return M
