player = animatable:new() 

function player:init(x, y, move_vx, move_vy) 
    self.x, self.y = x, y
    self.move_vx, self.move_vy = move_vx, move_vy 
    self.vx, self.vy = self.move_vx, self.move_vy
    self.dir_x, self.dir_y = 0, 0 
    
    self.ox, self.oy = tilesize / 2, tilesize / 2

    -- anims
    animatable.init(self) -- animatable baseclass 
    self.anim_speed = {
        player_wd = 0.25, 
        player_wu = 0.25, 
        player_wl = 0.25,
        player_wr = 0.25 
    }
    self.img = sprites['player']
    self:set_anim('player_wd')
end 

function player:update(dt)
    self.x = self.x + (self.dir_x * self.vx * dt)
    self.y = self.y + (self.dir_y * self.vy * dt)

    if self.dir_x == -1 then 
        self:set_anim('player_wl')
    elseif self.dir_x == 1 then 
        self:set_anim('player_wr')
    elseif self.dir_y == -1 then
        self:set_anim('player_wu') 
    elseif self.dir_y == 1 then 
        self:set_anim('player_wd')
    else
        -- if no movement => use the last frame of movement animation 
        self.quad = quads[self.anim_key][#quads[self.anim_key]]
    end

    if self.dir_x ~= 0 or self.dir_y ~= 0 then
        self:animate(dt)
    end 
end 

function player:draw() 
    love.graphics.setColor(1,1,1,1) 
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 