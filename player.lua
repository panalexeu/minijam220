player = animatable:new() 

function player:init(x, y, mv_vx, mv_vy, aurasize) 
    self.x, self.y = x, y
    self.mv_vx, self.mv_vy = mv_vx, mv_vy 
    self.vx, self.vy = self.mv_vx, self.mv_vy
    self.mv, self.dir_y = 0, 0 
    -- movement vector 
    self.mv_vec = {0, 0}
    -- last movement direction vector (where character faces)
    self.dir_vec = {1, 0} -- in idle => look down
    -- some action performing vecotr (e.g. punch, throw, etc.)
    self.action_vec = {0, 0} 
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
        player_pl = 0.25, 
        player_pr = 0.25, 
        player_pu = 0.25, 
        player_pd = 0.25
    }
    self.anim_lookup = {
        walk = {l='player_wl',r='player_wr',u='player_wu',d='player_wd'}, 
        carry = {l='player_cl',r='player_cr',u='player_cu',d='player_cd'}, 
        punch = {l='player_pl', r='player_pr', u='player_pu', d='player_pd'}, 
    } 
    self.action = 'walk'
    self:set_anim(self.anim_lookup[self.action]['d'])

    -- light aura 
    self.aurasize = aurasize
    self.aura_ox, self.aura_oy = self.aurasize / 2, self.aurasize / 2
    self.aura_img = create_auraimg(self.aurasize)
    self.aura_clr = {1, 0.85, 0.45, 1}
end 

function player:update(dt)
    -- normalize mv_vec by its length so there is no diagonal movement speedup
    local norm_vec = vec_d_scalar(self.mv_vec, vec_len(self.mv_vec))
    self.x = self.x + (norm_vec[1] * self.vx * dt)
    self.y = self.y + (norm_vec[2] * self.vy * dt)

    if self.carry_item ~= nil and self.carry_item:holdable() then self:drag_item() end 

    -- anims 
    if self.carry_item ~= nil then 
        self.action = 'carry'
    elseif vec_len(self.mv_vec) > 0 then  
        self.action = 'walk'
    elseif vec_len(self.action_vec) > 0 then 
        self.action = 'punch' 
    end 

    if vec_len(self.mv_vec) > 0 then 
        local str_dir = self:get_dir_str(self.mv_vec)
        self:set_anim(self.anim_lookup[self.action][str_dir])
    elseif vec_len(self.action_vec) > 0 then 
        local str_dir = self:get_dir_str(self.action_vec)
        self:set_anim(self.anim_lookup[self.action][str_dir])
    else  
        self:set_default_last_dir_anim()
    end 

    -- if player moves => animate, update direction 
    if vec_len(self.mv_vec) > 0 or vec_len(self.action_vec) > 0 then 
        self:animate(dt)
    end 

    if vec_len(self.mv_vec) > 0 then
        self.dir_vec = vec_cat(self.mv_vec, {}) -- just vec copy with vec_cat 
    end 
end 

function player:get_dir_str(vec)
    -- vec: two items vector x є [-1;1] and y є [-1;1] 
    -- returns str mapping
    dir_str = nil 
    if vec[1] == -1 then 
        dir_str = 'l'
    elseif vec[1] == 1 then 
        dir_str = 'r'
    elseif vec[2] == -1 then 
        dir_str = 'u'
    elseif vec[2] == 1 then 
        dir_str = 'd'
    end 
    return dir_str 
end 

function player:set_default_last_dir_anim()    
    dir_str = self:get_dir_str(self.dir_vec)
    anim_key = self.anim_lookup[self.action][dir_str]
    self.quad = quads[anim_key][#quads[anim_key]] 
end 

function player:draw() 
    love.graphics.setColor(1,1,1,1) 
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 

function player:draw_aura()
    love.graphics.setColor(self.aura_clr)
    love.graphics.draw(self.aura_img, self.x, self.y, 0, 1, 1, self.aura_ox, self.aura_oy)
end 

function player:drag_item()
    local offset_y = 10
    self.carry_item.x, self.carry_item.y = self.x, self.y - offset_y
end 

function player:throw_item() 
    self.carry_item.mv_vec = self.dir_vec
    self.carry_item = nil
    self.action = 'walk'
end 

function player:start_punch() 
    self.mv_vec = {0, 0}
    self.action_vec = self.dir_vec
end 

function player:end_punch()
    self.action_vec = {0, 0}
    self.action = 'walk'
end 