player = animatable:new() 

function player:init(x, y, mv_vx, mv_vy) 
    self.x, self.y = x, y
    self.mv_vx, self.mv_vy = mv_vx, mv_vy 
    self.vx, self.vy = self.mv_vx, self.mv_vy
    self.mv, self.dir_y = 0, 0 
    self.mv_vec = {0, 0}

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
    -- normalize mv_vec by its length so there is no diagonal movement speedup
    local norm_vec = vec_d_scalar(self.mv_vec, vec_len(self.mv_vec))
    self.x = self.x + (norm_vec[1] * self.vx * dt)
    self.y = self.y + (norm_vec[2] * self.vy * dt)

    if self.mv_vec[1] == -1 then 
        self:set_anim('player_wl')
    elseif self.mv_vec[1] == 1 then 
        self:set_anim('player_wr')
    elseif self.mv_vec[2] == -1 then
        self:set_anim('player_wu') 
    elseif self.mv_vec[2] == 1 then 
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