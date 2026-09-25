oreblock = class:new() 

function oreblock:init(x, y)
    self.x, self.y = x, y 
    self.ox, self.oy =  itemsize / 2, itemsize / 2 
    self.is_active = false
    self.item_offset = 1 
    self.color = {0.4, 0.8, 0.4, 1}
    self.img = sprites['oreblock']
    self.quad = quads['oreblock_df'][1]
end 

function oreblock:update(dt)
end

function oreblock:draw() 
    love.graphics.setColor(1,1,1,1)
    if self.is_active then 
        love.graphics.rectangle('fill', self.x - self.ox - self.item_offset, 
                                        self.y - self.oy - self.item_offset, 
                                        itemsize + self.item_offset * 2, itemsize + self.item_offset * 2)
    end 

    love.graphics.setColor(self.color)
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)

end 