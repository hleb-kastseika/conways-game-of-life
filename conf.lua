-- configuration file for LOVE framework
function love.conf(t)
  t.title = "Conway's Game Of Life"
  t.window.resizable = true
  t.window.fullscreentype = "desktop" 
  t.window.vsync = true
  t.window.icon = "life_icon.png"
end
