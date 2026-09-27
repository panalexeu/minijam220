function level_load(lvl) 
    gamestate = 'level'
    blind = 0
    bid = 0
    cur_score = 0 
    buyout_t = 0 
    level_end_t = 0
    
    -- objects 
    player_obj = nil
    belts,clusters = 0,0
    clusters_color = {}
    -- strict! objects order: belts, clusters, items, player
    objects = {}

    if lvl == 1 then 
        blind = 5000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 1,1
        cluster_color = {green}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,             -- x
                game_h / 2 - 6, -- y 
                game_w - 32,    -- w
                12,             -- h 
                120,            -- v 
                10,              -- items
                2,              -- item_cooldown 
                {green, blue},  -- colors
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,    -- x 
                game_h / 2 - 6, -- y 
                16,             -- w 
                12,             -- h 
                cluster_color[1]
            ),
            player_obj
        }
    elseif lvl ==  2 then 
        blind = 5000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 2,2
        cluster_color = {green, blue}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,           
                64 ,  
                game_w - 32,
                12,          
                120,         
                10,         
                2,           
                {green, blue},
                item_spawn_offset
            ), 
            belt:new(
                16,            
                game_h - 64 ,   
                game_w - 32,   
                12,             
                120,            
                0,             
                0,              
                {},  
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,    
                64,  
                16,            
                12,            
                cluster_color[1]
            ),
            cluster:new(
                game_w - 16,     
                game_h - 64,     
                16,              
                12,              
                cluster_color[2]
            ),
            player_obj
        } 
    elseif lvl ==  3 then 
        blind = 13000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 1,1
        cluster_color = {red}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,             
                game_h / 2 - 6,  
                game_w - 32,    
                12,              
                120,             
                15,             
                1.25,           
                {red, cyan, purple, white, teal}, 
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,     
                game_h / 2 - 6,  
                16,              
                12,              
                cluster_color[1]
            ),
            player_obj
        }
    elseif lvl ==  4 then 
        blind = 15000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 2,2
        cluster_color = {red, cyan}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,             
                64 ,             
                game_w - 32,    
                12,              
                120,             
                17,             
                1.25,            
                {red, cyan, white,},
                item_spawn_offset
            ), 
            belt:new(
                16,             
                game_h - 64 ,    
                game_w - 32,    
                12,              
                120,             
                0,              
                0,              
                {},  
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16, 
                64,  
                16,  
                12,  
                cluster_color[1]
            ),
            cluster:new(
                game_w - 16, 
                game_h - 64, 
                16,          
                12,          
                cluster_color[2]
            ),
            player_obj
        } 
    
    elseif lvl ==  5 then 
        blind = 20000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 3,3
        cluster_color = {red, white, cyan}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,            
                64 ,             
                game_w - 32,    
                12,              
                120,
                0,
                0,
                {},
                item_spawn_offset
            ), 
            belt:new(
                16,             
                game_h / 2 - 6,  
                game_w - 32,    
                12,              
                120,             
                22,             
                1.25,           
                {red, cyan, white,},
                item_spawn_offset
            ),
            belt:new(
                16,            
                game_h - 64 ,   
                game_w - 32,   
                12,             
                120,            
                0,             
                0,             
                {},  
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,     
                64, 
                16,  
                12,  
                cluster_color[1]
            ),
            cluster:new(
                game_w - 16,     
                game_h / 2 - 6,  
                16,              
                12,              
                cluster_color[2]
            ),
            cluster:new(
                game_w - 16,     
                game_h - 64,     
                16,              
                12,              
                cluster_color[3]
            ),
            player_obj
        } 
    elseif lvl == 6 then 
        blind = 25000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 3,3
        cluster_color = {orange, white, teal}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,            
                64 ,             
                game_w - 32,    
                12,              
                80,
                13,
                2,
                {white, teal},
                item_spawn_offset
            ), 
            belt:new(
                16,             
                game_h / 2 - 6,  
                game_w - 32,    
                12,              
                100,             
                13,             
                2,           
                {orange},
                item_spawn_offset
            ),
            belt:new(
                16,            
                game_h - 64 ,   
                game_w - 32,   
                12,             
                120,            
                0,             
                0,             
                {},  
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,     
                64, 
                16,  
                12,  
                cluster_color[1]
            ),
            cluster:new(
                game_w - 16,     
                game_h / 2 - 6,  
                16,              
                12,              
                cluster_color[2]
            ),
            cluster:new(
                game_w - 16,     
                game_h - 64,     
                16,              
                12,              
                cluster_color[3]
            ),
            player_obj
        } 
    elseif lvl == 7 then 
        blind = 40000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 1,1
        cluster_color = {pink}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,             
                game_h / 2 - 6,  
                game_w - 32,    
                12,              
                120,             
                43,             
                1.1,              
                {green, blue, cyan, purple, pink, red, orange, yellow, white, teal},  
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,    -- x 
                game_h / 2 - 6, -- y 
                16,             -- w 
                12,             -- h 
                cluster_color[1]
            ),
            player_obj
        }
    elseif lvl == 8 then 
        blind = 30000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 4,4
        cluster_color = {blue, yellow, white, green}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,            
                32,             
                game_w - 32,    
                12,              
                120,
                0,
                0,
                {},
                item_spawn_offset
            ), 
            belt:new(
                16,             
                64,  
                game_w - 32,    
                12,              
                80,             
                13,             
                3,           
                {yellow, blue},
                item_spawn_offset
            ),
            belt:new(
                16,            
                96,   
                game_w - 32,   
                12,             
                80,            
                17,             
                2,             
                {green, white},  
                item_spawn_offset
            ), 
            belt:new(
                16,            
                128,   
                game_w - 32,   
                12,             
                120,            
                0,             
                0,             
                {},  
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,     
                32, 
                16,  
                12,  
                cluster_color[1]
            ),
            cluster:new(
                game_w - 16,     
                64,  
                16,              
                12,              
                cluster_color[2]
            ),
            cluster:new(
                game_w - 16,     
                96,     
                16,              
                12,              
                cluster_color[3]
            ),
            cluster:new(
                game_w - 16,     
                128,     
                16,              
                12,              
                cluster_color[4]
            ),
            player_obj
        } 
    elseif lvl == 9 then
        blind = 35000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 2,2
        cluster_color = {yellow, blue}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,           
                72 ,  
                game_w - 32,
                12,          
                100,         
                17,         
                2,           
                {blue},
                item_spawn_offset
            ), 
            belt:new(
                16,            
                game_h - 72 ,   
                game_w - 32,   
                12,             
                60,            
                18,             
                2,              
                {yellow},  
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,    
                72,  
                16,            
                12,            
                cluster_color[1]
            ),
            cluster:new(
                game_w - 16,     
                game_h - 72,     
                16,              
                12,              
                cluster_color[2]
            ),
            player_obj
        } 
    elseif lvl == 10 then 
        blind = 25000
        bid = 1000 
        buyout_t = 5
        level_end_t = buyout_t + 2
        player_obj = player:new(game_w/2 , game_h/2 + 32, 100, 48)
        belts, clusters = 2,2
        cluster_color = {white, teal}
        item_spawn_offset = belts + clusters + 1
        objects = {
            belt:new(
                16,           
                96 ,  
                game_w - 32,
                12,          
                120,         
                25,         
                1.25,           
                {green, blue, cyan, purple, pink, red, orange, yellow, white, teal},
                item_spawn_offset
            ), 
            belt:new(
                16,            
                game_h - 96 ,   
                game_w - 32,   
                12,             
                60,            
                0,             
                0,              
                {yellow},  
                item_spawn_offset
            ), 
            cluster:new(
                game_w - 16,    
                96,  
                16,            
                12,            
                cluster_color[1]
            ),
            cluster:new(
                game_w - 16,     
                game_h - 96,     
                16,              
                12,              
                cluster_color[2]
            ),
            player_obj
        } 
    end 

    -- lighting system 
    light_canvas = love.graphics.newCanvas(game_w, game_h)
    -- claude suggested these values: 
    ambient_color = {0.30, 0.33, 0.45, 1}
    back_color    = {0.18, 0.17, 0.22, 1}
end 

function level_update(dt)
    update_player_input() 
    
    for i,obj in ipairs(objects) do 
        -- updates
        if obj.__baseclass == belt then 
            obj:update(dt, objects)
        else 
            obj:update(dt)
        end
        
        -- objects sepcific 
        if obj.__baseclass == item then
            -- player-object collision 
            if obj_overlap(obj, player_obj) 
               and obj:pickable() 
               and player_obj.carry_item == nil then 
                obj.mv_vec = {0,0} 
                obj.is_on_belt = false
                player_obj.carry_item = obj 
                sounds['land']:clone():play()
            -- collisions that are applied for items that are not carried by player 
            elseif obj ~= player_obj.carry_item then
                -- object-belt collision 
                local belt_i = item_belts_col(obj, belts)
                if belt_i ~= nil then
                    local belt_obj = objects[belt_i]
                    obj.is_on_belt = true 
                    obj.y = belt_obj.y_item 
                    obj.mv_vec = vec_cat(belt_obj.mv_vec,{})
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
                        sounds['catch']:clone():play()
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

    if is_buyout_phase() then 
        buyout_t = buyout_t - dt 
        level_end_t = level_end_t - dt
    end
    if buyout_t <= 0 then 
        buyout()
    end 
    if level_end_t <= 0 then 
        gamestate = 'menu'
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
    local s = 'score*' .. cur_score .. ' ' .. 'blind*' .. blind  .. ' ' .. 'lvl*' .. lvl
    properprint(s, 0, game_h - 8, 1)
end 

function draw_back() 
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(sprites['back'], 0, 0, 0, 1, 1)
end 

-- controls 
function level_keypressed(key)
    if key == 'e' and player_obj.carry_item ~= nil then 
        player_obj:throw_item()
        sounds['start']:clone():play()    
    end
end 

function level_keyreleased(key)
end 

function update_player_input() 
    -- cmart player control suggeted by claude: 
    local kd = love.keyboard.isDown 
    player_obj.mv_vec[1] = (kd('d') and 1 or 0) - (kd('a') and 1 or 0)
    player_obj.mv_vec[2] = (kd('s') and 1 or 0) - (kd('w') and 1 or 0)
    player_obj.v = kd('lshift') and player_obj.v_sprint or player_obj.mv_v
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

-- stuff 

function spawn_score(x,y,bid)
    table.insert(objects, score:new(bid, x, y, 75))
end

function score_cleanup(i, obj)
    if obj.t >= obj.lifetime then 
        table.remove(objects, i)
    end
end 

function is_buyout_phase() 
    s = 0 
    for i=1,belts do 
        s = s + objects[i].item_count
    end 
    return s == 0
end 

function buyout()
    for i,obj in ipairs(objects) do
        if obj.__baseclass == item then 
            if contains(obj.color, clusters_color) == -1 then
                cur_score = cur_score + bid 
                spawn_score(obj.x,obj.y,bid)
                table.remove(objects,i)
                sounds['purchuase']:play()
            else 
                cur_score = cur_score - bid 
                spawn_score(obj.x,obj.y,-bid)
                table.remove(objects,i)
                 sounds['catch']:play()
            end 
        end 
    end

    if cur_score >= blind then 
        lvls_state[lvl] = true
    end
end 