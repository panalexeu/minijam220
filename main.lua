function love.load() 
    require "class"

    gamestate = 'load'

    sprites = {} 
    quads = {} 
    load_sprite('player', 'player.png')
end 

function love.draw() 
end 

function love.update(dt)
end 


function load_sprite(key, path) 
    sprites[key] = love.graphics.newImage('assets/' .. path)
end 

function load_quads(key, )
end 
