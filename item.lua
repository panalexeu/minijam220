item = class:new() 

function item:init(x, y, belt_mv, mv, gravity, aurasize, color)
    self.x, self.y = x, y
    self.ox, self.oy =  itemsize / 2, itemsize / 2 
    self.belt_mv = belt_mv 
    self.mv = mv
    self.v = self.mv
    self.belt_v = self.belt_mv 
    self.gravity = gravity 
    self.mv_vec = {0, 0}
    self.is_on_belt = false
    self.pick_cooldown = 1
    self.t = 0

    self.color = color
    self.img = sprites['ore']
    self.quad = quads['ore_df'][1]

    self.aurasize = aurasize
    self.aura_ox, self.aura_oy = self.aurasize / 2, self.aurasize / 2
    self.aura_img = create_auraimg(self.aurasize)
    self.aura_clr = {1, 0.85, 0.45, 1}
end 

function item:update(dt)
    if self.t > 0 then 
        self.t = math.max(0, self.t - dt)
    end 

    if not self.is_on_belt then 
        if vec_len(self.mv_vec) >= 1 then 
            self.v = self.v - self.gravity * dt
        end 

        if self.v <= 0 then 
            self.mv_vec = {0, 0}
            self.v = self.mv
        end 

        self.x = self.x + (self.mv_vec[1] * self.v * dt)
        self.y = self.y + (self.mv_vec[2] * self.v * dt)
    else 
        self.x = self.x + (self.mv_vec[1] * self.belt_v * dt)
    end

end 

function item:draw()
    love.graphics.setColor(self.color)
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
    -- TODO: for some reason otherwise everything is green when item is draw after player wtf
    love.graphics.setColor(1,1,1,1)
end 

function item:draw_aura()
    love.graphics.setColor(self.color)
    love.graphics.draw(self.aura_img, self.x, self.y, 0, 1, 1, self.aura_ox, self.aura_oy)
end

function item:holdable()
    return vec_len(self.mv_vec) == 0 
end

function item:pickable() 
    return self.t == 0 
end