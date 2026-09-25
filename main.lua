function love.load() 
    require "utils"
    require "class"
    
    require "animatable"
    require "player"
    require "level"

    -- game variables/constants 
    gamestate = 'load'
    tilesize = 16 
    game_w, game_h = 400, 224 
    
    -- window/screen stuff 
    love.window.setMode(game_w, game_h)

    sprites = {} 
    quads = {} 
    load_sprite('player', 'player.png')
    load_quads('player_wd', 0, 0, 16, 4)

    level_load()
end 

function love.draw() 
    if gamestate == 'level' then 
        level_draw()
    end
end 

function love.update(dt)
    if gamestate == 'level' then 
        level_update(dt)
    end 
end 

function love.keypressed(key)
    if gamestate == 'level' then 
        level_keypressed(key)
    end 

    if key == 'escape' then 
        love.event.quit(0)
    end 
end

function love.keyreleased(key)
    if gamestate == 'level' then 
        level_keyreleased(key)
    end 
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
