

Player = {}
Player2 = {}

function Player:load()
 self.width = 20
 self.height = 100
 self.x = 50
 self.y = love.graphics.getHeight() / 2 - self.height / 2
 self.speed = 500
 self.puntuacion = 0
end


function Player2:load()
 self.width = 20
 self.height = 100
 self.x = love.graphics.getWidth() - 50 - self.width
 self.y = love.graphics.getHeight() / 2 - self.height / 2
 self.speed = 500
 self.puntuacion = 0 
end



function Player:update(dt)
 self:move(dt)
 check_boundaries(self)
end


function Player2:update(dt)
 self:move(dt)
 check_boundaries(self)
end


function Player:move(dt)
  if love.keyboard.isDown("w") then
    self.y = self.y - self.speed * dt
  elseif love.keyboard.isDown("s") then
    self.y = self.y + self.speed * dt
  end
end

function Player2:move(dt)
  if love.keyboard.isDown("up") then
    self.y = self.y - self.speed * dt
  elseif love.keyboard.isDown("down") then
    self.y = self.y + self.speed * dt
  end
end

function check_boundaries(player)
  if player.y < 0 then
    player.y = 0
  elseif player.y + player.height > love.graphics.getHeight() then
    player.y = love.graphics.getHeight() - player.height
  end
end

function draw(player)
  love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end