function create_auraimg(aurasize) 
    local img_data = love.image.newImageData(aurasize, aurasize)
    img_data:mapPixel(function(x,y)
        local d = math.sqrt((x-aurasize/2)^2 + (y-aurasize/2)^2) / (aurasize/2)
        return 1,1,1, math.max(0, 1-d)^2
    end)
    img = love.graphics.newImage(img_data) 
    return img 
end 