_MARGIN_WIDTH = 10
_BUTTON_WIDTH = 120
_BUTTON_HEIGHT = 50
_BUTTON_MARGIN_WIDTH = 40
_BUTTON_MARGIN_HEIGHT = 20
_UNIVERSE_SIZE =_CONFIGS.window.height - _MARGIN_WIDTH * 2
_GRID_BORDER_SIZE = 1

function love.draw()
  drawUniverseBorder()
  drawButtons()
  --drawGrid()
  drawRandomCells()
end

function drawUniverseBorder()
  love.graphics.setColor(64,243,19,250)
  love.graphics.rectangle("line", _MARGIN_WIDTH, _MARGIN_WIDTH, _UNIVERSE_SIZE + 5, _UNIVERSE_SIZE + 5)
  love.graphics.setColor(0,0,0,250)
  love.graphics.rectangle("line", _MARGIN_WIDTH + 1, _MARGIN_WIDTH + 1, _UNIVERSE_SIZE + 3, _UNIVERSE_SIZE + 3)
end

function drawButtons()  
  local xCoorditate = _CONFIGS.window.width - _BUTTON_WIDTH - _MARGIN_WIDTH
  local xLabelCoorditate = _CONFIGS.window.width - _BUTTON_WIDTH - _MARGIN_WIDTH + _BUTTON_MARGIN_WIDTH  
  local buttonLabels = {"Start", "Pause", "Reset"} --button label  
  for i=1,#buttonLabels do
    love.graphics.setColor(130,130,130) --buttons color
    local yCoorditate = _MARGIN_WIDTH * i + _BUTTON_HEIGHT * (i-1)
    local yLabelCoorditate = _MARGIN_WIDTH * i + _BUTTON_HEIGHT * (i-1) + _BUTTON_MARGIN_HEIGHT
    love.graphics.rectangle("fill", xCoorditate, yCoorditate, _BUTTON_WIDTH, _BUTTON_HEIGHT)
    
    love.graphics.setColor(255,255,255,250) --button labels color
    love.graphics.print(buttonLabels[i], xLabelCoorditate, yLabelCoorditate)
  end
end

--[[
function drawGrid()
  for i=0,_UNIVERSE_SIZE,5 do
    for j=0,_UNIVERSE_SIZE,5 do
      love.graphics.setColor(175,115,63,100)
      love.graphics.rectangle("fill", _MARGIN_WIDTH + 2 + i, _MARGIN_WIDTH + 2 + j, 4, 4)
    end
  end
end
]]

function drawRandomCells()
  for i=0,_UNIVERSE_SIZE,5 do
    for j=0,_UNIVERSE_SIZE,5 do
      local isLive = math.random(0, 10) 
      if isLive == 1 then
        love.graphics.setColor(64,243,19,250)        
      else
        love.graphics.setColor(175,115,63,100)
      end
      love.graphics.rectangle("fill", _MARGIN_WIDTH + 2 + i, _MARGIN_WIDTH + 2 + j, 4, 4)
    end
  end
end
