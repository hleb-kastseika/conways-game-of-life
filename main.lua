require "cell"
require "button"

function love.load()
  --rgb colors
  _GREEN_COLOR = {64, 243, 19, 250}
  _BLACK_COLOR = {0, 0, 0, 250}
  _GREY_COLOR = {130, 130, 130, 250}
  _WHITE_COLOR = {255, 255, 255, 250}
  _BROWN_COLOR = {175,115,63,100}
  
  _IS_STARTED = false
  _IS_PAUSED = true
  _MARGIN_WIDTH = 10
  _BUTTON_WIDTH = 120
  _BUTTON_HEIGHT = 50
  _BUTTON_MARGIN_WIDTH = 40
  _BUTTON_MARGIN_HEIGHT = 20
  _UNIVERSE_SIZE =_CONFIGS.window.height - _MARGIN_WIDTH * 2
  _GRID_BORDER_SIZE = 1 
  _CELL_SIZE = 4
  _CELL_GRID_SIZE = math.floor(_UNIVERSE_SIZE/(_CELL_SIZE+_GRID_BORDER_SIZE))
  
  --populate initial cell array
  _CELL_GRID = {}
  generateInitialCells()  
  _OLD_CELL_GRID = clone(_CELL_GRID)
  
  _BUTTONS = {
    Button.new("Start", 
             function()
               _IS_STARTED = true
               _IS_PAUSED = false
               generateInitialCells()
             end),
    Button.new("Pause", 
             function()
               if _IS_PAUSED then
                 _IS_PAUSED = false
               else
                  _IS_PAUSED = true
               end
             end),
    Button.new("Clear", 
             function()
               _IS_STARTED = false
               _IS_PAUSED = true
             end)
  }
end

function getColor(rgbColor)
  return rgbColor[1], rgbColor[2], rgbColor[3], rgbColor[4]
end

function love.draw()
  drawUniverseBorder()
  drawButtons()  
  if _IS_STARTED then    
    if not _IS_PAUSED then
      calculateNewGeneration()
      drawCells(_CELL_GRID)
    else
      drawCells(_OLD_CELL_GRID)
    end
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
  for i=0,_UNIVERSE_SIZE,_CELL_SIZE+_GRID_BORDER_SIZE do
    for j=0,_UNIVERSE_SIZE,_CELL_SIZE+_GRID_BORDER_SIZE do
      love.graphics.setColor(getColor(_BROWN_COLOR))
      love.graphics.rectangle("fill", _MARGIN_WIDTH + 2 + i, _MARGIN_WIDTH + 2 + j, _CELL_SIZE, _CELL_SIZE)
    end
  end
end

function drawCells(cellGrid)
  for i=0,#cellGrid do
    for j=0,#cellGrid do
      if cellGrid[i][j].isAlive then
        love.graphics.setColor(getColor(_GREEN_COLOR))        
      else
        love.graphics.setColor(getColor(_BROWN_COLOR))
      end
      love.graphics.rectangle("fill", cellGrid[i][j].x, cellGrid[i][j].y, _CELL_SIZE, _CELL_SIZE)
    end
  end
end

function calculateNewGeneration()
  _OLD_CELL_GRID = clone(_CELL_GRID)
  _CELL_GRID = {}
  for i=0,_CELL_GRID_SIZE do
    _CELL_GRID[i] = {}
    for j=0,_CELL_GRID_SIZE do
      local oldCell = _OLD_CELL_GRID[i][j]      
      
      local neighbors = {}
      local tempCell = nil
      
      tempCell = getUpperLeft(i,j)
      if tempCell ~= nil then
        table.insert(neighbors, tempCell)
      end
      
      tempCell = getUpper(i,j)
      if tempCell ~= nil then
        table.insert(neighbors, tempCell)
      end
      
      tempCell = getUpperRight(i,j)
      if tempCell ~= nil then
        table.insert(neighbors, tempCell)
      end
      
      tempCell = getLeft(i,j)
      if tempCell ~= nil then
        table.insert(neighbors, tempCell)
      end
      
      tempCell = getRight(i,j)
      if tempCell ~= nil then
        table.insert(neighbors, tempCell)
      end
      
      tempCell = getBottomLeft(i,j)
      if tempCell ~= nil then
        table.insert(neighbors, tempCell)
      end
      
      tempCell = getBottom(i,j)
      if tempCell ~= nil then
        table.insert(neighbors, tempCell)
      end

      tempCell = getBottomRight(i,j)
      if tempCell ~= nil then
        table.insert(neighbors, tempCell)
      end
      
      local liveNeighborsCount = 0
      for i=1,#neighbors do
        if neighbors[i].isAlive then 
          liveNeighborsCount = liveNeighborsCount + 1
        end
      end
       
      local newCell = clone(oldCell)
      if oldCell.isAlive and (liveNeighborsCount < 2 or liveNeighborsCount > 3) then
        newCell.isAlive = false
      end
        
      if not oldCell.isAlive and liveNeighborsCount == 3 then
        newCell.isAlive = true
      end
      
      _CELL_GRID[i][j] = newCell
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
    love.timer.sleep(0.5)
  end
end

--catch buttons clicks
function love.mousepressed(x, y)
  for i=1,#_BUTTONS do
    if x > _BUTTONS[i].xCoorditate and x < _BUTTONS[i].xCoorditate + _BUTTON_WIDTH
        and y > _BUTTONS[i].yCoorditate and y < _BUTTONS[i].yCoorditate + _BUTTON_HEIGHT then
      _BUTTONS[i].action()
    end
  end
end

function getUpperLeft(i,j)
  if i>0 and j>0 then 
    return _OLD_CELL_GRID[i-1][j-1]
  else
    return nil
  end
end

function getUpper(i,j)
  if j>0 then 
    return _OLD_CELL_GRID[i][j-1]
  else
    return nil
  end
end

function getUpperRight(i,j)
  if i>0 and j<#_OLD_CELL_GRID then 
    return _OLD_CELL_GRID[i-1][j+1]
  else
    return nil
  end
end

function getLeft(i,j)
  if i>0 then 
    return _OLD_CELL_GRID[i-1][j]
  else
    return nil
  end
end

function getRight(i,j)
  if i<#_OLD_CELL_GRID then 
    return _OLD_CELL_GRID[i+1][j]
  else
    return nil
  end
end

function getBottomLeft(i,j)
  if i>0 and j<#_OLD_CELL_GRID then 
    return _OLD_CELL_GRID[i-1][j+1]
  else
    return nil
  end
end

function getBottom(i,j)
  if j<#_OLD_CELL_GRID then 
    return _OLD_CELL_GRID[i][j+1]
  else
    return nil
  end
end

function getBottomRight(i,j)
  if i<#_OLD_CELL_GRID and j<#_OLD_CELL_GRID then 
    return _OLD_CELL_GRID[i+1][j+1]
  else
    return nil
  end
end

function generateInitialCells()
  for i=0,_CELL_GRID_SIZE do
    _CELL_GRID[i] = {}
    for j=0,_CELL_GRID_SIZE do      
      local cell = Cell.new(
                     _MARGIN_WIDTH + 2 + i*(_CELL_SIZE+_GRID_BORDER_SIZE),
                     _MARGIN_WIDTH + 2 + j*(_CELL_SIZE+_GRID_BORDER_SIZE), 
                     math.random(0, 10) == 1 and true or false)                   
      _CELL_GRID[i][j] = cell
    end
  end
end

function clone(t) -- deep-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            target[k] = clone(v)
        else
            target[k] = v
        end
    end
    setmetatable(target, meta)
    return target
end
