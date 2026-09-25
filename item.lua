item = class:new() 

function item:init()
    self.x, self.y = nil, nil
    self.ox, self.oy =  itemsize / 2, itemsize / 2 
    self.color = {0.4, 0.8, 0.4, 1}
    self.img = sprites['ore']
    self.quad = quads['ore_df'][1]
end 

function item:update(dt)
end 

function item:draw()
    love.graphics.setColor(self.color)
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 