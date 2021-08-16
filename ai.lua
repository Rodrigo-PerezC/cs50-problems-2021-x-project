

AI = {}


function AI:load()
 self.width = 20
 self.height = 100
 self.x = love.graphics.getWidth() - self.width - 50
 self.y = love.graphics.getHeight() / 2 - self.height / 2
 self.yVel = 0
 self.speed = 500
 self.puntuacion = 0
 self.timer = 0
 self.rate = 0.4
 self.puntuacion = 0
end


function AI:update(dt)
 self.timer = self.timer + dt
 if self.timer > self.rate then
  self.timer = 0
  self:check_target()
 end
 self:move(dt)
 check_boundaries(AI)
end


function AI:move(dt)
 self.y = self.y + self.yVel * dt 
end


function AI:check_target()
 if Ball.y + Ball.height < self.y then
  self.yVel = -self.speed
 elseif Ball.y > self.y + self.height then
  self.yVel = self.speed
 else
  self.yVel = 0
 end
end


