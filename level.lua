function level_load() 
    gamestate = 'level'

    objects = {
        player:new(game_w/2 , game_h/2, 200, 100)
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