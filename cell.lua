Cell = {}

function Cell.new(x, y, isAlive)
  local o = {}
  o.x = x
  o.y = y
  o.isAlive = isAlive
  setmetatable(o, { __index = Cell })
  return o
end
