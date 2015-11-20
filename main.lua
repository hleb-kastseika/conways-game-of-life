function love.load()
  --rgb colors
  _GREEN_COLOR = {64, 243, 19, 250}
  _BLACK_COLOR = {0, 0, 0, 250}
  _GREY_COLOR = {130, 130, 130, 250}
  _WHITE_COLOR = {255, 255, 255, 250}
  _BROWN_COLOR = {175,115,63,100} 
  
  _IS_STARTED = false
  _MARGIN_WIDTH = 10
  _BUTTON_WIDTH = 120
  _BUTTON_HEIGHT = 50
  _BUTTON_MARGIN_WIDTH = 40
  _BUTTON_MARGIN_HEIGHT = 20
  _UNIVERSE_SIZE =_CONFIGS.window.height - _MARGIN_WIDTH * 2
  _GRID_BORDER_SIZE = 1  
  _BUTTONS = {
    {
      name="Start",
      action=function()
        _IS_STARTED = true
      end
    },
    {
      name="Pause",
      action=function()
        --do nothing
      end
    },
    {
      name="Clear",
      action=function()
        _IS_STARTED = false
      end
    }
  }
end

function getColor(rgbColor)
  return rgbColor[1], rgbColor[2], rgbColor[3], rgbColor[4]
end

function love.draw()
  drawUniverseBorder()
  drawButtons()
  
  if _IS_STARTED then
    drawRandomCells()
  else
    drawEmptyCells()
  end
end

function drawUniverseBorder()
  love.graphics.setColor(getColor(_GREEN_COLOR))
  love.graphics.rectangle("line", _MARGIN_WIDTH, _MARGIN_WIDTH, _UNIVERSE_SIZE + 5, _UNIVERSE_SIZE + 5)
  love.graphics.setColor(getColor(_BLACK_COLOR))
  love.graphics.rectangle("line", _MARGIN_WIDTH + 1, _MARGIN_WIDTH + 1, _UNIVERSE_SIZE + 3, _UNIVERSE_SIZE + 3)
end

function drawButtons()  
  local xCoorditate = _CONFIGS.window.width - _BUTTON_WIDTH - _MARGIN_WIDTH
  local xLabelCoorditate = _CONFIGS.window.width - _BUTTON_WIDTH - _MARGIN_WIDTH + _BUTTON_MARGIN_WIDTH
  for i=1,#_BUTTONS do  
    _BUTTONS[i].xCoorditate = xCoorditate
    _BUTTONS[i].xLabelCoorditate = xLabelCoorditate    
    love.graphics.setColor(getColor(_GREY_COLOR)) --buttons color
    local yCoorditate = _MARGIN_WIDTH * i + _BUTTON_HEIGHT * (i-1)
    local yLabelCoorditate = _MARGIN_WIDTH * i + _BUTTON_HEIGHT * (i-1) + _BUTTON_MARGIN_HEIGHT
    _BUTTONS[i].yCoorditate = yCoorditate
    _BUTTONS[i].yLabelCoorditate = yLabelCoorditate
    love.graphics.rectangle("fill", xCoorditate, yCoorditate, _BUTTON_WIDTH, _BUTTON_HEIGHT)
    love.graphics.setColor(getColor(_WHITE_COLOR)) --button labels color
    love.graphics.print(_BUTTONS[i].name, xLabelCoorditate, yLabelCoorditate)
  end
end

function drawEmptyCells()
  for i=0,_UNIVERSE_SIZE,5 do
    for j=0,_UNIVERSE_SIZE,5 do
      love.graphics.setColor(getColor(_BROWN_COLOR))
      love.graphics.rectangle("fill", _MARGIN_WIDTH + 2 + i, _MARGIN_WIDTH + 2 + j, 4, 4)
    end
  end
end

function drawRandomCells()
  for i=0,_UNIVERSE_SIZE,5 do
    for j=0,_UNIVERSE_SIZE,5 do
      local isLive = math.random(0, 10) 
      if isLive == 1 then
        love.graphics.setColor(getColor(_GREEN_COLOR))        
      else
        love.graphics.setColor(getColor(_BROWN_COLOR))
      end
      love.graphics.rectangle("fill", _MARGIN_WIDTH + 2 + i, _MARGIN_WIDTH + 2 + j, 4, 4)
    end
  end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
  end
end

function love.update(dt)
	if _IS_STARTED then
		love.timer.sleep(1.5)
  end
end

function love.mousepressed(x, y)
  for i=1,#_BUTTONS do
    if x > _BUTTONS[i].xCoorditate and x < _BUTTONS[i].xCoorditate + _BUTTON_WIDTH
        and y > _BUTTONS[i].yCoorditate and y < _BUTTONS[i].yCoorditate + _BUTTON_HEIGHT then
      _BUTTONS[i].action()
		end
  end
end
