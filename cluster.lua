cluster = class:new()

function cluster:init(
    x, y, 
    w, h, 
    color
) 
    self.x, self.y = x, y 
    self. w, self.h = w, h 
    self.color = color 

    --particles 
    local data = love.image.newImageData(1,1)
    data:setPixel(0,0,1,1,1,1) -- x,y,r,g,b,a
    local pimg = love.graphics.newImage(data)
    self.ps = love.graphics.newParticleSystem(pimg, 50)
    self.ps:setParticleLifetime(0.5, 1)
    self.ps:setSpeed(5, 20)
    self.ps:setSpread(math.pi * 4)
    self.ps:setLinearAcceleration(-32, 0, -32, 32)        
    self.ps:setColors(1, 1, 1, 1,  1, 1, 1, 0)  
    self.ps:setSizes(2, 1)
    self.ps:setPosition(self.x - 2, self.y + self.h / 2)
end 

function cluster:update(dt)
    self.ps:update(dt)
end 

function cluster:draw() 
    love.graphics.setColor(self.color) 
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end 

function cluster:draw_aura() 
    love.graphics.setColor(self.color)
    love.graphics.draw(self.ps)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

function cluster:emit() 
    self.ps:emit(50)
end