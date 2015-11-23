Button = {}

function Button.new(name, action)
  local o = {}
  o.name = name
  o.action = action
  setmetatable(o, { __index = Button })
  return o
end
