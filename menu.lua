function menu_load() 
    pointer = 1
    gamestate = 'menu' 

    title = 'crystal*sort'
    instr = '*use arrow keys to select| a level then press enter'
    offset_x = 8
    offset_y = 12
end 

function menu_update(dt)
end

function menu_draw() 
    love.graphics.clear(0,0,0,1)

    love.graphics.setColor(yellow)
    properprint(title, 0, 0, 2)
    love.graphics.setColor(1,1,1,1)
    properprint(instr, 0, 18, 1)

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
