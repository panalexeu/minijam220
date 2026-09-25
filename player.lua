player = class:new() 

function player:init(x, y, move_v) 
    self.img = sprites['player']
    self.quad = quads['player_wd'][1]
    self.ox, self.oy = tilesize / 2, tilesize / 2
end 

function player:update(dt)
end 

function player:draw() 
    love.graphics.setColor(1,1,1,1) 
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, self.ox, self.oy)
end 