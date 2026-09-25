function level_load() 
    gamestate = 'level'

    player_obj = player:new(game_w/2 , game_h/2, 100, 100)
    item_obj = item:new(game_w/2+32, game_h/2+32, 240, 600)
    ore_block_obj = ore_block:new(game_w/2, game_h/2)
    objects = {
        item_obj,
        ore_block_obj,
        player_obj, 

    }
end 

function level_update(dt)
    for i,obj in ipairs(objects) do 
        obj:update(dt)
        if obj.__baseclass == item then
            if obj_overlap(obj, player_obj) and obj:holdable() then player_obj.carry_item = obj end 
        end
    end 
end 

function level_draw() 
    love.graphics.clear(0,0,0,1)

    for i,obj in ipairs(objects) do 
        obj:draw()
    end
end 

function level_keypressed(key)
    if key == 'a' then player_obj.mv_vec[1] = -1
    elseif key == 'd' then player_obj.mv_vec[1] = 1 
    elseif key == 'w' then player_obj.mv_vec[2] = -1
    elseif key == 's' then player_obj.mv_vec[2] = 1
    elseif key == 'e' and player_obj.carry_item ~= nil then player_obj:throw_item() 
    elseif key == 'e' and player_obj.carry_item == nil then player_obj:start_punch()
    end
end 

function level_keyreleased(key)
    if key == 'a' then player_obj.mv_vec[1] = 0
    elseif key == 'd' then player_obj.mv_vec[1] = 0 
    elseif key == 'w' then player_obj.mv_vec[2] = 0
    elseif key == 's' then player_obj.mv_vec[2] = 0
    elseif key == 'e' then player_obj:end_punch()
    end
end 

-- collisions 
function obj_overlap(obj, player_obj)
    -- AABB overlap (axis-aligned bounding box)
    return math.abs(obj.x - player_obj.x) < obj.ox + player_obj.ox 
           and math.abs(obj.y - player_obj.y) < obj.oy + player_obj.oy
end 
