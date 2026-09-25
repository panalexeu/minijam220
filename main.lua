function love.load() 
    require "utils"
    require "class"
    
    require "animatable"
    require "player"
    require "level"
    require "item"
    require "oreblock"
    require "aura"
    require "tile"

    -- game variables/constants 
    gamestate = 'load'
    tilesize = 16 
    itemsize = 8
    
    -- window/screen stuff 
    game_w, game_h = 400, 224 
    window_w, window_h = 800, 448
    love.window.setMode(window_w, window_h)
    screen = love.graphics.newCanvas(game_w, game_h)
    screen_scale = math.min(window_w / game_w, window_h / game_h)
    screen_offset_x = math.floor((window_w - game_w * screen_scale) / 2)
    screen_offset_y = math.floor((window_h - game_h * screen_scale) / 2)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('minijam220')

    sprites = {} 
    quads = {} 
    load_sprite('player', 'player.png')
    -- walk 
    load_quads('player_wd', 0, 0, 16, 4)
    load_quads('player_wu', 0, 1, 16, 4)
    load_quads('player_wl', 0, 2, 16, 4)
    load_quads('player_wr', 0, 3, 16, 4)
    -- carry
    load_quads('player_cd', 12, 0, 16, 4)
    load_quads('player_cu', 12, 1, 16, 4)
    load_quads('player_cl', 12, 2, 16, 4)
    load_quads('player_cr', 12, 3, 16, 4)
    -- punch 
    load_quads('player_pd', 24, 0, 16, 4)
    load_quads('player_pu', 24, 1, 16, 4)
    load_quads('player_pl', 24, 2, 16, 4)
    load_quads('player_pr', 24, 3, 16, 4)
    -- TODO skip for now 
    -- slash 
    load_quads('player_sd', 26, 0, 16, 4)
    load_quads('player_su', 26, 1, 16, 4)
    load_quads('player_sl', 26, 2, 16, 4)
    load_quads('player_sr', 26, 3, 16, 4)

    load_sprite('ore', 'ore.png')
    load_quads('ore_df', 0, 0, 8, 1)
    load_sprite('oreblock', 'oreblock.png') 
    load_quads('oreblock_df', 0, 0, 8, 1) 
    load_quads('oreblock_break', 1, 0, 8, 5)
    load_sprite('rail', 'rail.png')
    load_quads('rail_df', 0, 0, 16, 1)

    level_load()
end 

function love.draw() 
    love.graphics.setCanvas(screen)

    if gamestate == 'level' then 
        level_draw()
    end

    love.graphics.setCanvas() 
    love.graphics.draw(screen, screen_offset_x, screen_offset_y, 0, screen_scale, screen_scale)

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

function mousepos2gamepos(x, y)
    return (x - screen_offset_x) / screen_scale, (y - screen_offset_y) / screen_scale
end