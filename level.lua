function level_load() 
    gamestate = 'level'
    blind = 10000
    bid = 1000
    cur_score = 0 

    -- objects 
    player_obj = player:new(game_w/2 , game_h/2, 100, 48)
    item_obj = item:new(game_w/2+32, game_h/2+32, 120, 240, 600, 32, pink)
    -- objects order: belts, clusters, items, player
    belts, clusters = 2, 2 
    item_spawn_offset = belts + clusters + 1
    objects = {
        belt:new(
            16, 
            64, 
            game_w - 32, 
            12, 
            240, 
            20, 
            1.5, 
            {green, pink, white, yellow}, 
            item_spawn_offset
        ),
        belt:new(
            16, 
            game_h - 64, 
            game_w - 32, 
            12, 
            240, 
            0, 
            0, 
            {}, 
            item_spawn_offset
        ),
        cluster:new(game_w-16, 64, 16, 12, pink),
        cluster:new(game_w-16, game_h-64, 16, 12, yellow),
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
            if obj_overlap(obj, player_obj) 
               and obj:pickable() 
               and player_obj.carry_item == nil then 
                obj.mv_vec = {0,0} 
                obj.is_on_belt = false
                player_obj.carry_item = obj 
            -- collisions that are applied for items that are not carried by player 
            elseif obj ~= player_obj.carry_item then
                -- object-belt collision 
                local belt_i = item_belts_col(obj, belts)
                if belt_i ~= nil then
                    local belt_obj = objects[belt_i]
                    obj.is_on_belt = true 
                    obj.y = belt_obj.y_item 
                    obj.mv_vec = vec_cat(belt_obj.mv_vec,{})
                    sounds['start']:clone():play()
                end
                --cluster-belt collision 
                local cluster_i = item_cluster_col(obj, clusters)
                if cluster_i ~= nil then 
                    local cluster_obj = objects[cluster_i]
                    if obj.color == cluster_obj.color then 
                        cur_score = cur_score + bid
                        spawn_score(obj.x,obj.y, bid)
                        sounds['purchuase']:clone():play()
                    else 
                        cur_score = cur_score - bid 
                        spawn_score(obj.x,obj.y, -bid)
                    end 
                    table.remove(objects, i)
                end
                -- obj-bounding_box collisions 
                if not obj.is_on_belt then 
                    bounding_box_item_col(obj)
                end 
            end 
        elseif obj.__baseclass == player then 
            bounding_box_player_col(obj)
        elseif obj.__baseclass == score then 
            score_cleanup(i, obj)
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

    -- print score 
    local s = 'score*' .. cur_score .. ' ' .. 'blind*' .. blind 
    properprint(s, 0, game_h - 8, 1)
end 

function draw_back() 
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(sprites['back'], 0, 0, 0, 1, 1)
end 

-- controls 
function level_keypressed(key)
    if key == 'a' then player_obj.mv_vec[1] = -1 end
    if key == 'd' then player_obj.mv_vec[1] = 1 end
    if key == 'w' then player_obj.mv_vec[2] = -1 end
    if key == 's' then player_obj.mv_vec[2] = 1 end
    if key == 'e' and player_obj.carry_item ~= nil then player_obj:throw_item() end
    if key == 'lshift' then player_obj.v = player_obj.v_sprint end
end 

function level_keyreleased(key)
    if key == 'a' then player_obj.mv_vec[1] = 0 end
    if key == 'd' then player_obj.mv_vec[1] = 0 end
    if key == 'w' then player_obj.mv_vec[2] = 0 end
    if key == 's' then player_obj.mv_vec[2] = 0 end
    if key == 'lshift' then player_obj.v = player_obj.mv_v end 
end 

-- collisions 
function obj_overlap(obj, player_obj)
    -- AABB overlap (axis-aligned bounding box)
    return math.abs(obj.x - player_obj.x) < obj.ox + player_obj.ox 
           and math.abs(obj.y - player_obj.y) < obj.oy + player_obj.oy
end 

function obj_rect_overlap(obj, rect)
    return math.abs(obj.x - rect.x) < obj.ox + rect.w 
           and math.abs(obj.y - rect.y) < obj.oy + rect.h
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
        if obj_rect_overlap(obj, objects[i]) and not obj.is_on_belt then 
            return i
        end
    end 
    return nil 
end 

function item_cluster_col(obj, clusters)
    for i=1,clusters do 
        i = belts + i 
        if obj_rect_overlap(obj, objects[i]) and obj.is_on_belt then 
            return i
        end 
    end
    return nil
end 

function spawn_score(x,y,bid)
    table.insert(objects, score:new(bid, x, y, 75))
end

function score_cleanup(i, obj)
    if obj.t >= obj.lifetime then 
        table.remove(objects, i)
    end
end 