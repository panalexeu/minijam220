function menu_load() 
    pointer = 1
    gamestate = 'menu' 

    title = 'crystal*sort'
    instr = 'guide|*use arrow keys to select| a level, then press enter|*press escape to return| to the menu or exit|*use wasd to move|*hold shift to sprint|*to pick up a crystal,| just walk into it|*press e to throw a crystal|*sort crystals by matching| them to the belt color|*crystals that match no belt| color go on the floor|*good luck!'
    offset_x = 8
    offset_y = 12
end 

function menu_update(dt)
end

function menu_draw() 
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(sprites['menu_back'], 0, 0, 0, 1, 1)

    love.graphics.setColor(yellow)
    properprint(title, 4, 4, 2)
    love.graphics.setColor(1,1,1,1)
    properprint(instr, game_w / 2 - 28, 32, 1)

    for i=1,lvls do 
        love.graphics.setColor(red)
        if lvls_state[i] == true then
            love.graphics.setColor(green) 
        end
        
        local s = 'lvl ' .. i 
        if i == pointer then 
            s = '*' .. s 
        end 
        properprint(s, offset_x, 30 + (i * offset_y), 1)
    end 
    love.graphics.setColor(1,1,1,1)
end 

function incr_pointer() pointer = math.min(lvls, pointer+1) end 

function decr_pointer() pointer = math.max(1, pointer-1) end

function menu_keypressed(key)
    if key == 'up' then  decr_pointer()
    elseif key == 'down' then incr_pointer()
    elseif key == 'return' then lvl = pointer  level_load(lvl)
    end 
end 
