oreblock = animatable:new() 

function oreblock:init(x, y, aurasize)
    self.x, self.y = x, y 
    self.ox, self.oy =  itemsize / 2, itemsize / 2 
    self.is_active = false
    self.is_broken = false
    self.item_offset = 1

    self.color = {0.4, 0.8, 0.4, 1}
    self.t = nil
    self.break_t = 4

    -- anim
    animatable.init(self)
    self.img = sprites['oreblock']
    self.base_quad = quads['oreblock_df'][1]
    self:set_default_quad()
    self.anim_speed = {
        oreblock_break = 1
    }
    
    self.aurasize = aurasize
    self.aura_ox, self.aura_oy = self.aurasize / 2, self.aurasize / 2
    self.aura_img = create_auraimg(self.aurasize)
    self.aura_clr = {1, 0.85, 0.45, 1}
    
end 

function oreblock:update(dt)
    if self.t ~= nil then 
        self.t = self.t - dt

        if self.t <= 0 then 
            self.is_broken = true
        end

        self:animate(dt)
    end  
end

function oreblock:draw() 
    if self.is_active then 
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle('fill', self.x - self.ox - self.item_offset, 
                                        self.y - self.oy - self.item_offset , 
                                        itemsize + self.item_offset * 2, itemsize + self.item_offset * 2)
    end 

    love.graphics.setColor(self.color)
    love.graphics.draw(self.img, self.base_quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
    love.graphics.draw(self.img, self.quad, self.x, self.y, 0, 1, 1, self.ox, self.oy)
end 

function oreblock:draw_aura()
    love.graphics.setColor(self.aura_clr)
    love.graphics.draw(self.aura_img, self.x, self.y, 0, 1, 1, self.aura_ox, self.aura_oy)
end 

function oreblock:init_break_t()
    self.t = self.break_t 
    self:set_anim('oreblock_break')
end

function oreblock:nil_break_t()
    self.t = nil
    self:set_default_quad()
end 

function oreblock:set_default_quad()
    self.quad = quads['oreblock_break'][1]
end
