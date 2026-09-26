belt = class:new() 

function belt:init(x, y, w, h, v, items, item_cooldown, colors, item_spawn_pos)
    self.x, self.y = x, y
    self.y_item = self.y + itemsize / 2
    self.v = v
    self.h, self.w = h, w
    self.items = items
    self.item_count = self.items
    self.item_cooldown = item_cooldown 
    self.colors = colors 
    self.item_spawn_pos = item_spawn_pos
    self.color = {0.9, 0.7, 0.2, 1}  

    self.t = 0 
    self.mv_vec = {1, 0} -- mv in right direction 
end 

function belt:spawn_item() 
    local belt_v = self.v
    local v = 240
    local gravity = 600
    local aurasize = 32
    local color = self.colors[love.math.random(#self.colors)]
    local item = item:new(self.x, self.y_item, belt_v, v, gravity, aurasize, color) 
    item.mv_vec = self.mv_vec 
    item.is_on_belt = true
    return item 
end 

function belt:next_item(objects) 
    self.t = 0 
    self.item_count = self.item_count - 1
    table.insert(objects, self.item_spawn_pos, self:spawn_item())
    --                    ^ belts always come first  
end

function belt:update(dt, objects)
    self.t =  self.t + dt
    if self.t >= self.item_cooldown and self.item_count > 0 then 
        self:next_item(objects)
    end 
end

function belt:draw() 
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end 

function belt:draw_aura() 
end 

