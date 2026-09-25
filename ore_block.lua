ore_block = class:new() 

function ore_block:init(x, y)
    self.x, self.y = x, y 
    self.ox, self.oy =  itemsize / 2, itemsize / 2 

    self.color = {0.4, 0.8, 0.4, 1}
    self.img = sprites['oreblock']
    self.quad = quads['oreblock_df'][1]
end 

function ore_block:update(dt)
end

function ore_block:draw() 
    love.graphics.setColor(self.color)
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 