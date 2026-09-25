player = animatable:new() 

function player:init(x, y, mv_vx, mv_vy) 
    self.x, self.y = x, y
    self.mv_vx, self.mv_vy = mv_vx, mv_vy 
    self.vx, self.vy = self.mv_vx, self.mv_vy
    self.mv, self.dir_y = 0, 0 
    self.mv_vec = {0, 0}
    self.ox, self.oy = tilesize / 2, tilesize / 2
    self.carry_item = nil 

    -- anims
    animatable.init(self) -- animatable baseclass 
    self.img = sprites['player']
    self.anim_speed = {
        player_wd = 0.25, 
        player_wu = 0.25, 
        player_wl = 0.25,
        player_wr = 0.25, 
        player_cd = 0.25, 
        player_cu = 0.25, 
        player_cl = 0.25,
        player_cr = 0.25, 
    }
    self.anim_lookup = {
        walk = {l='player_wl',r='player_wr',u='player_wu',d='player_wd'}, 
        carry = {l='player_cl',r='player_cr',u='player_cu',d='player_cd'} 
    } 
    self.action = 'walk'
    self:set_anim(self.anim_lookup[self.action]['d'])
end 

function player:update(dt)
    if self.carry_item ~= nil then self:drag_item() end 

    -- normalize mv_vec by its length so there is no diagonal movement speedup
    local norm_vec = vec_d_scalar(self.mv_vec, vec_len(self.mv_vec))
    self.x = self.x + (norm_vec[1] * self.vx * dt)
    self.y = self.y + (norm_vec[2] * self.vy * dt)

    -- anims 
    if self.carry_item ~= nil then 
        self.action = 'carry'
    else 
        self.action = 'walk'
    end 

    if self.mv_vec[1] == -1 then 
        self:set_anim(self.anim_lookup[self.action]['l'])
    elseif self.mv_vec[1] == 1 then 
        self:set_anim(self.anim_lookup[self.action]['r'])
    elseif self.mv_vec[2] == -1 then
        self:set_anim(self.anim_lookup[self.action]['u']) 
    elseif self.mv_vec[2] == 1 then 
        self:set_anim(self.anim_lookup[self.action]['d'])
    else
        -- if no movement => use the last frame of movement animation 
        self.quad = quads[self.anim_key][#quads[self.anim_key]]
    end

    if vec_len(self.mv_vec) >= 1 then
        self:animate(dt)
    end 
end 

function player:draw() 
    love.graphics.setColor(1,1,1,1) 
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 

function player:set_carry_item(obj)
    self.carry_item = obj 
end 

function player:drag_item()
    local offset_y = 10
    self.carry_item.x, self.carry_item.y = self.x, self.y - offset_y
end 