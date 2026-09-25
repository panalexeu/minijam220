tile = class:new() 
tilesize = 16 

function tile:init(x, y) 
    self.x, self.y = x, y 
    self.ox, self.oy = tilesize / 2, tilesize / 2 
    self.img = nil
    self.quad = nil
end 

function tile:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 

function tile:draw_aura() 
end 

function tile:update(dt)
end

rail = tile:new() 

function rail:init(x, y)
    tile.init(self, x, y)
    self.img = sprites['rail']
    self.quad = quads['rail_df'][1]
end 