oreblock = animatable:new() 

function oreblock:init(x, y, aurasize)
    self.x, self.y = x, y 
    self.ox, self.oy =  itemsize / 2, itemsize / 2 
    self.is_active = false
    self.item_offset = 1

    self.color = {0.4, 0.8, 0.4, 1}
    self.img = sprites['oreblock']
    self.quad = quads['oreblock_df'][1]

    self.aurasize = aurasize
    self.aura_ox, self.aura_oy = self.aurasize / 2, self.aurasize / 2
    self.aura_img = create_auraimg(self.aurasize)
    self.aura_clr = {1, 0.85, 0.45, 1}
end 

function oreblock:update(dt)
end

function oreblock:draw() 
    if self.is_active then 
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle('fill', self.x - self.ox - self.item_offset, 
                                        self.y - self.oy - self.item_offset , 
                                        itemsize + self.item_offset * 2, itemsize + self.item_offset * 2)
    end 

    love.graphics.setColor(self.color)
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 

function oreblock:draw_aura()
    love.graphics.setColor(self.aura_clr)
    love.graphics.draw(self.aura_img, self.x, self.y, 0, 1, 1, self.aura_ox, self.aura_oy)
end 