

Ball = {}
function Ball:load()
   self.x = love.graphics.getWidth() / 2
   self.y = love.graphics.getHeight() / 2
   self.width = 20
   self.height = 20
   self.speed = 300
   self.xVel = -self.speed
   self.yVel = 0
end


function Ball:update(dt)
  self:collide()
  self:move(dt)
  check_score()
end

function check_direction(self,player)
  if self.x < (love.graphics.getWidth() / 2) then
    self.speed = 300
  else
    self.speed = -300
  end
  self.xVel = self.speed
  local middleBall = self.y + self.height / 2
  local middlePlayer = player.y + player.height / 2
  local collisionPosition = middleBall - middlePlayer
  self.yVel = collisionPosition * 5
end



function Ball:collide()
  
  if checkCollision(self, Player) then
    check_direction(self, Player)
  end
  
  if game_state == '2 Players' then
    if checkCollision(self, Player2) then
      check_direction(self, Player2)
    end
  end
  
  if game_state == 'game' then
   if checkCollision(self, AI) then
      check_direction(self, AI)
   end
  end

  if self.y < 0 then
    self.y = 0
    self.yVel = -self.yVel
  elseif self.y + self.height > love.graphics.getHeight() then
    self.y = love.graphics.getHeight() - self.height
    self.yVel = -self.yVel
  end

  if self.x < 0 then
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.yVel = 0
    self.xVel = 250
    if game_state == 'game' then
      AI.puntuacion = AI.puntuacion + 1
    end
    if game_state == '2 Players' then
      Player2.puntuacion = Player2.puntuacion + 1
    end
  end

  if self.x + self.width > love.graphics.getWidth() then
    Player.puntuacion = Player.puntuacion + 1
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.yVel = 0
    self.xVel = -250
  end
end


function Ball:move(dt)
  self.x = self.x + self.xVel * dt
  self.y = self.y + self.yVel * dt
end


function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function check_score()
  if game_state == '2 Players' then
    if Player2.puntuacion == 3 then
      game_state = "P2win"
    elseif Player.puntuacion == 3 then
      game_state = "P1win"
    end
  elseif game_state == "game" then
    if AI.puntuacion == 3 then
      game_state = "lose"
    elseif Player.puntuacion == 3 then
      game_state = "win"
    end
  end
end