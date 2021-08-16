require("player")
require("ball")
require("ai")


local menus = { '1 Player', '2 Players', 'Quit' }
local selected_menu_item = 1
local window_width
local window_height
local font_height

-- this is the sound of hitting a padding
local rebote = love.audio.newSource("hit.wav", "static")

function love.load()
  love.window.setTitle("Ping pong")
  game_state = 'menu'
  Player:load()
  Ball:load()
  AI:load()
  Player2:load()
  window_width, window_height = love.graphics.getDimensions()
  local font = love.graphics.setNewFont(30)
  font_height = font:getHeight()
end

function love.update(dt)

  if game_state == 'game' then
    Ball:update(dt)
    Player:update(dt)
    AI:update(dt)
  end
  
  if game_state == '2 Players' then
    
    Ball:update(dt)
    Player:update(dt)
    Player2:update(dt)
  end
  
  if game_state == 'menu' then
    love.load()
  end
end


function love.draw()
  
  if game_state == 'menu' then
    draw_menu()

  elseif game_state == '2 Players' then
    draw_2players()

  elseif game_state == "win" then
    draw_win()
    
  elseif game_state == "lose" then
    draw_lose()
  
  elseif game_state == "P1win" then
    draw_P1win()
    
  elseif game_state == "P2win" then
    draw_P2win()
  else -- game_state == 'game'
    draw_game()
  end

end

function draw_menu()

  local horizontal_center = window_width / 2
  local vertical_center = window_height / 2
  local start_y = vertical_center - (font_height * (#menus / 2)) - font_height
  
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.printf("WELCOME", 0, 100, window_width, 'center')

  -- draw menu items
  for i = 1, #menus do
    if i == selected_menu_item then
      love.graphics.setColor(0, 0.5, 1, 1)
    else
      love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.printf(menus[i], 0, start_y + font_height * (i-1) + i * 30, window_width, "center")
  end

end


  --draw the game vs Player 2
function draw_2players()
  love.graphics.print(Player.puntuacion, (love.graphics.getWidth() / 2) - 300, 50)
  love.graphics.print(Player2.puntuacion, (love.graphics.getWidth() / 2) + 270, 50)
  draw(Player)
  Ball:draw()
  draw(Player2)
  love.graphics.rectangle("fill",(love.graphics.getWidth() / 2),0, 5, love.graphics.getHeight())
end

    --draw the game vs AI
function draw_game()
  love.graphics.print(Player.puntuacion, (love.graphics.getWidth() / 2) - 300, 50)
  love.graphics.print(AI.puntuacion, (love.graphics.getWidth() / 2) + 270, 50)
  draw(Player)
  Ball:draw()
  draw(AI)
  love.graphics.rectangle("fill",(love.graphics.getWidth() / 2),0, 5, love.graphics.getHeight())
end

function draw_win()
  love.graphics.printf("YOU WIN!!", 0, 150, window_width, "center")
  love.graphics.printf("Press esc to back to menu", 0, 300, window_width, "center")
end

function draw_lose()
  love.graphics.printf("YOU LOSE :(", 0, 150, window_width, "center")
  love.graphics.printf("Press esc to back to menu", 0, 300, window_width, "center")
end

function draw_P1win()
  love.graphics.printf("PLAYER 1 WIN!", 0, 150, window_width, "center")
  love.graphics.printf("Press esc to back to menu", 0, 300, window_width, "center")
end

function draw_P2win()
  love.graphics.printf("PLAYER 2 WIN!", 0, 150, window_width, "center")
  love.graphics.printf("Press esc to back to menu", 0, 300, window_width, "center")
end

function love.keypressed(key, scan_code, is_repeat)
-- check for esc
  if game_state == 'menu' then
    menu_keypressed(key)

  elseif game_state == '2 Players' then
    game_keypressed_esc(key)

  else
    game_keypressed_esc(key)

  end

end

function menu_keypressed(key)

  -- pressing Esc on the main menu to quits the game
  if key == 'escape' then
    love.event.quit()

  elseif key == 'up' then

    selected_menu_item = selected_menu_item - 1

    if selected_menu_item < 1 then
      selected_menu_item = #menus
    end

  elseif key == 'down' then

    selected_menu_item = selected_menu_item + 1

    if selected_menu_item > #menus then
      selected_menu_item = 1
    end

  elseif key == 'return' then

    if menus[selected_menu_item] == '1 Player' then
      game_state = 'game'

    elseif menus[selected_menu_item] == '2 Players' then
      game_state = '2 Players'

    elseif menus[selected_menu_item] == 'Quit' then
      love.event.quit()
    end

  end

end

function game_keypressed_esc(key)
  if key == 'escape' then
    game_state = 'menu'
  end

end

function checkCollision(A, B)
  if not ((B.x > A.x + A.width) or (B.y > A.y + A.height) or (B.x + B.width < A.x) or (B.y + B.height < A.y)) then
    rebote:play()
    return true
  else
    return false
  end
end
