function level_load() 
    gamestate = 'level'

    player_obj = player:new(game_w/2 , game_h/2, 100, 48)
    item_obj = item:new(game_w/2+32, game_h/2+32, 120, 240, 600, 32, pink)
    belts = 2
    objects = {
        belt:new(16, 32, game_w - 32, 12, 20, 2, {green, pink, white, yellow}, belts),
        belt:new(16, game_h - 32, game_w - 32, 12, 0, 0, {}, belts),
        item_obj,
        player_obj, 
    }

    -- lighting system 
    light_canvas = love.graphics.newCanvas(game_w, game_h)
    -- claude suggested these values: 
    ambient_color = {0.30, 0.33, 0.45, 1}
    back_color    = {0.18, 0.17, 0.22, 1}
end 

function level_update(dt)
    for i,obj in ipairs(objects) do 
        
        if obj.__baseclass == belt then 
            obj:update(dt, objects)
        else 
            obj:update(dt)
        end

        if obj.__baseclass == item then
            -- player-object collision 
            if obj_overlap(obj, player_obj) and obj:pickable() then 
                obj.mv_vec = {0,0} 
                obj.is_on_belt = false
                player_obj.carry_item = obj 
            -- object-belt collision 
            else
                local belt_i = item_belts_col(obj, belts)
                if belt_i ~= nil then
                    local belt_obj = objects[belt_i]
                    obj.is_on_belt = true 
                    obj.y = belt_obj.y 
                    obj.mv_vec = belt_obj.mv_vec
                end      
            end 
        elseif obj.__baseclass == player then 
            bounding_box_player_col(obj)
        end

    end 
end 

function level_draw() 
    love.graphics.setCanvas(light_canvas)
    love.graphics.setBlendMode('add')
    love.graphics.clear(ambient_color)
    for i,obj in ipairs(objects) do 
            obj:draw_aura()
    end
    love.graphics.setBlendMode('alpha')

    love.graphics.setCanvas(screen)
    draw_back()
    for i,obj in ipairs(objects) do 
            obj:draw()
    end

    love.graphics.setBlendMode('multiply', 'premultiplied')
    love.graphics.draw(light_canvas)
    love.graphics.setBlendMode('alpha')
end 

function draw_back() 
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(sprites['back'], 0, 0, 0, 1, 1)
end 

-- controls 
function level_keypressed(key)
    if key == 'a' then player_obj.mv_vec[1] = -1
    elseif key == 'd' then player_obj.mv_vec[1] = 1 
    elseif key == 'w' then player_obj.mv_vec[2] = -1
    elseif key == 's' then player_obj.mv_vec[2] = 1
    elseif key == 'e' and player_obj.carry_item ~= nil then player_obj:throw_item() 
    end
    if key == 'lshift' then player_obj.v = player_obj.v_sprint end
end 

function level_keyreleased(key)
    if key == 'a' then player_obj.mv_vec[1] = 0
    elseif key == 'd' then player_obj.mv_vec[1] = 0 
    elseif key == 'w' then player_obj.mv_vec[2] = 0
    elseif key == 's' then player_obj.mv_vec[2] = 0
    end
    if key == 'lshift' then player_obj.v = player_obj.mv_v end 
end 

-- collisions 
function obj_overlap(obj, player_obj)
    -- AABB overlap (axis-aligned bounding box)
    return math.abs(obj.x - player_obj.x) < obj.ox + player_obj.ox 
           and math.abs(obj.y - player_obj.y) < obj.oy + player_obj.oy
end 

function obj_belt_overlap(obj, belt)
    return math.abs(obj.x - belt.x) < obj.ox + belt.w 
           and math.abs(obj.y - belt.y) < obj.oy + belt.h
end 

function mouse_overlap(obj, x, y)
    return (x > obj.x - obj.ox) and (x < obj.x + obj.ox) and (y > obj.y - obj.oy) and (y < obj.y + obj.oy)
end

function bounding_box_player_col(obj)
    local box_offset = 16 
    local box_mult = 1.5
    local box_w, box_h = game_w - box_offset, game_h - box_offset 

    if (obj.x + obj.ox) >= box_w then 
        obj.mv_vec = {0,0}
        obj.x = box_w - obj.ox * box_mult
    elseif (obj.x - obj.ox) <= box_offset then 
        obj.mv_vec = {0,0}
        obj.x = box_offset + obj.ox * box_mult
    elseif (obj.y + obj.oy) >= box_h then 
        obj.mv_vec = {0, 0}
        obj.y = box_h - obj.oy * box_mult
    elseif (obj.y - obj.oy) <= box_offset then 
        obj.mv_vec = {0, 0}
        obj.y = box_offset + obj.oy * box_mult
    end 
end 

function bounding_box_item_col(obj)
    local box_offset = 16 
    local box_w, box_h = game_w - box_offset, game_h - box_offset 

    if (obj.x + obj.ox) >= box_w then 
        obj.mv_vec[1] = -1 
    elseif (obj.x - obj.ox) <= box_offset then 
        obj.mv_vec[1] = 1
    elseif (obj.y + obj.oy) >= box_h then 
        obj.mv_vec[2] = -1
    elseif (obj.y - obj.oy) <= box_offset then 
        obj.mv_vec[2] = 1
    end 
end 

function item_belts_col(obj, belts)
    for i=1,belts do
        if obj_belt_overlap(obj, objects[i]) and not obj.is_on_belt then 
            return i
        end
    end 
    return nil 
end 