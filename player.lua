player = animatable:new() 

function player:init(x, y, move_vx, move_vy) 
    self.x, self.y = x, y
    self.move_vx, self.move_vy = move_vx, move_vy 
    self.vx, self.vy = self.move_vx, self.move_vy
    self.dir_x, self.dir_y = 0, 0 
    
    self.img = sprites['player']
    self.quad = quads['player_wd'][1]
    self.ox, self.oy = tilesize / 2, tilesize / 2
end 

function player:update(dt)
    self.x = self.x + (self.dir_x * self.vx * dt)
    self.y = self.y + (self.dir_y * self.vy * dt)
end 

function player:draw() 
    love.graphics.setColor(1,1,1,1) 
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 