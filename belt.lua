belt = class:new() 

function belt:init(x, y, w, h, items, item_cooldown, colors, belts)
    self.x, self.y = x, y 
    self.h, self.w = h, w
    self.items = items
    self.item_cooldown = item_cooldown 
    self.colors = colors 
    self.belts = belts 
    
    self.t = 0 
    self.item_count = 0
    self.mv_vec = {1, 0} -- mv in right direction 
end 

function belt:spawn_item() 
    local belt_v = 120
    local v = 240
    local gravity = 600
    local aurasize = 32
    local color = self.colors[love.math.random(#self.colors)]
    local item = item:new(self.x, self.y, belt_v, v, gravity, aurasize, color) 
    item.mv_vec = self.mv_vec 
    item.is_on_belt = true
    return item 
end 

function belt:next_item(objects) 
    self.t = 0 
    self.item_count = self.item_count + 1
    table.insert(objects, self.belts+1, self:spawn_item())
    --                    ^ belts always come first  
end

function belt:update(dt, objects)
    self.t =  self.t + dt
    if self.t >= self.item_cooldown and self.item_count < self.items then 
        self:next_item(objects)
    end 
end

function belt:draw() 
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end 

function belt:draw_aura() 
end 

