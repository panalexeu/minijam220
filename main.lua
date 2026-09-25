function love.load() 
    require "class"
    require "utils"

    -- game variables/constants 
    gamestate = 'load'
    tilesize = 16 

    sprites = {} 
    quads = {} 
    load_sprite('player', 'player.png')
    load_quads('player_wd', 0, 0, 16, 4)
end 

function love.draw() 
end 

function love.update(dt)
end 


function load_sprite(key, path) 
    sprites[key] = love.graphics.newImage('assets/' .. path)
end 

function load_quads(key, x_offset, y_offset, tilesize, frames)
    local prfx = split(key, '_')[1]
    local img = sprites[prfx]
    local t = {} 
    for i=0, frames-1 do 
        local x = x_offset * tilesize + i * tilesize
        local y = y_offset * tilesize 
        local quad = love.graphics.newQuad(x, y, tilesize, tilesize, img:getWidth(), img:getHeight())
        table.insert(t, quad)
    end 
    quads[key] = t 
end 
