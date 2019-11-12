function displayFPS()
    love.graphics.setColor(colors['black'])
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 0, 0)
end

function loadData()
    -- using the bitser library data is serialized for and deserialized for easy storage
    if love.filesystem.exists('save-data.dat') then
        return bitser.loadLoveFile('save-data.dat')
    else
        newGame = true
    end
end

function saveReset()
    love.filesystem.remove("save-data.dat")
end

function saveData(data)
    thread:start(channel)
    channel:push(data)
end

function setColor(color)
    local r, g, b, a = love.graphics.getColor()

    -- research showed setColor lags when overused 
    if r ~= color[1] and g ~= color[2] or b ~= color[3] then 
        love.graphics.setColor(color)
    end
end