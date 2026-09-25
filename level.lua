function level_load() 
    gamestate = 'level'

    player_obj = player:new(game_w/2 , game_h/2, 100, 100)
    objects = {
        player_obj
    }
end 

function level_update(dt)
    for i,obj in ipairs(objects) do 
        obj:update(dt)
    end 
end 

function level_draw() 
    for i,obj in ipairs(objects) do 
        obj:draw()
    end
end 

function level_keypressed(key)
    if key == 'a' then player_obj.mv_vec[1] = -1
    elseif key == 'd' then player_obj.mv_vec[1] = 1 
    elseif key == 'w' then player_obj.mv_vec[2] = -1
    elseif key == 's' then player_obj.mv_vec[2] = 1
    end
end 

function level_keyreleased(key)
    if key == 'a' then player_obj.mv_vec[1] = 0
    elseif key == 'd' then player_obj.mv_vec[1] = 0 
    elseif key == 'w' then player_obj.mv_vec[2] = 0
    elseif key == 's' then player_obj.mv_vec[2] = 0
    end
end 