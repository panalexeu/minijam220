cluster = class:new()

function cluster:init(
    x, y, 
    w, h, 
    color
) 
    self.x, self.y = x, y 
    self. w, self.h = w, h 
    self.color = color 
end 

function cluster:update(dt)
end 

function cluster:draw() 
    love.graphics.setColor(self.color) 
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end 

function cluster:draw_aura() 
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end