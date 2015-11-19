_MARGIN_WIDTH = 10
_BUTTON_WIDTH = 120
_BUTTON_HEIGHT = 50
_BUTTON_MARGIN_WIDTH = 40
_BUTTON_MARGIN_HEIGHT = 20
_UNIVERSE_SIZE = (_CONFIGS.window.height - _MARGIN_WIDTH * 2) < (_CONFIGS.window.width - _MARGIN_WIDTH * 3 - _BUTTON_WIDTH) 
    and _CONFIGS.window.height - _MARGIN_WIDTH * 2
    or _CONFIGS.window.width - _MARGIN_WIDTH * 3 - _BUTTON_WIDTH

function love.draw()
  drawUniverseBorder()
  drawButtons()
end

function drawUniverseBorder()
  love.graphics.setColor(64,243,19,250) --border color
  love.graphics.rectangle("line", _MARGIN_WIDTH, _MARGIN_WIDTH, _UNIVERSE_SIZE, _UNIVERSE_SIZE)
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
