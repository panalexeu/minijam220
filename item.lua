item = class:new() 

function item:init(x, y, mv, gravity, aurasize)
    self.x, self.y = x, y
    self.ox, self.oy =  itemsize / 2, itemsize / 2 
    self.mv = mv
    self.v = self.mv
    self.aurasize = aurasize
    self.gravity = gravity 
    self.mv_vec = {0, 0}

    self.color = {0.4, 0.8, 0.4, 1}
    self.img = sprites['ore']
    self.quad = quads['ore_df'][1]

    self.aurasize = aurasize
    self.aura_ox, self.aura_oy = self.aurasize / 2, self.aurasize / 2
    self.aura_img = create_auraimg(self.aurasize)
    self.aura_clr = {1, 0.85, 0.45, 1}
end 

function item:update(dt)
    if vec_len(self.mv_vec) >= 1 then 
        self.v = self.v - self.gravity * dt
    end 

    if self.v <= 0 then 
        self.mv_vec = {0, 0}
        self.v = self.mv
    end 

    self.x = self.x + (self.mv_vec[1] * self.v * dt)
    self.y = self.y + (self.mv_vec[2] * self.v * dt)
end 

function item:draw()
    love.graphics.setColor(self.color)
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 

function item:draw_aura()
    love.graphics.setColor(self.aura_clr)
    love.graphics.draw(self.aura_img, self.x, self.y, 0, 1, 1, self.aura_ox, self.aura_oy)
end

function item:holdable()
    return vec_len(self.mv_vec) == 0 
end