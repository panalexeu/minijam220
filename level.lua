function level_load() 
    gamestate = 'level'

    player_obj = player:new(game_w/2 , game_h/2, 100, 100, 48)
    item_obj = item:new(game_w/2+32, game_h/2+32, 240, 600, 32)
    rails = get_rails()
    objects = {
        item_obj,
        oreblock:new(game_w/2 + 8, game_h/2, 32),
        oreblock:new(game_w/2 + 16, game_h/2, 32),
        oreblock:new(game_w/2 + 16, game_h/2 + 8, 32),
        player_obj, 
    }
    objects = vec_cat(rails, objects)
    active_obj = nil

    -- lighting system 
    light_canvas = love.graphics.newCanvas(game_w, game_h)
    ambient_color = {0.30, 0.33, 0.45, 1}
    back_color    = {0.18, 0.17, 0.22, 1}
end 

function level_update(dt)
    local mouse_x, mouse_y = mousepos2gamepos(love.mouse.getPosition())
    
    for i,obj in ipairs(objects) do 
        obj:update(dt)
        if obj.__baseclass == item then
            if obj_overlap(obj, player_obj) and obj:holdable() then player_obj.carry_item = obj end 
        elseif obj.__baseclass == oreblock then 
            if mouse_overlap(obj, mouse_x, mouse_y) then 
                -- TODO think what do with this: active obj stays even if there is no mouse on it positioned 
                active_obj = obj 
                active_obj.is_active = true 
            else 
                obj.is_active = false
            end 
            if obj.is_broken then 
                table.remove(objects, i)
                local item = item:new(obj.x, obj.y, 240, 600, 32)
                table.insert(objects, item)
            end 
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
    love.graphics.clear(back_color)
    for i,obj in ipairs(objects) do 
            obj:draw()
    end

    love.graphics.setBlendMode('multiply', 'premultiplied')
    love.graphics.draw(light_canvas)
    love.graphics.setBlendMode('alpha')
end 

function level_keypressed(key)
    if key == 'a' then player_obj.mv_vec[1] = -1
    elseif key == 'd' then player_obj.mv_vec[1] = 1 
    elseif key == 'w' then player_obj.mv_vec[2] = -1
    elseif key == 's' then player_obj.mv_vec[2] = 1
    elseif key == 'e' and player_obj.carry_item ~= nil then player_obj:throw_item() 
    elseif key == 'e' and player_obj.carry_item == nil then 
        player_obj:start_punch()
        if active_obj ~= nil then active_obj:init_break_t() end 
    end
end 

function level_keyreleased(key)
    if key == 'a' then player_obj.mv_vec[1] = 0
    elseif key == 'd' then player_obj.mv_vec[1] = 0 
    elseif key == 'w' then player_obj.mv_vec[2] = 0
    elseif key == 's' then player_obj.mv_vec[2] = 0
    elseif key == 'e' then 
        player_obj:end_punch()
        if active_obj ~= nil then active_obj:nil_break_t() end
    end
end 

-- collisions 
function obj_overlap(obj, player_obj)
    -- AABB overlap (axis-aligned bounding box)
    return math.abs(obj.x - player_obj.x) < obj.ox + player_obj.ox 
           and math.abs(obj.y - player_obj.y) < obj.oy + player_obj.oy
end 

function mouse_overlap(obj, x, y)
    return (x > obj.x - obj.ox) and (x < obj.x + obj.ox) and (y > obj.y - obj.oy) and (y < obj.y + obj.oy)
end

-- stuff 
function get_rails() 
    local t = {}
    for i=0,game_h/2 do 
        table.insert(t, rail:new(game_w / 2, i*tilesize))
    end 
    return t 
end 