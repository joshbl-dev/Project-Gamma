function displayFPS()
    setColor(colors['black'])
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

function loadAchievementData()
    if love.filesystem.exists('achievement-data.dat') then
        return bitser.loadLoveFile('achievement-data.dat')
    end
end

function saveAchievementData(data)
    thread:start(channel)
    achievementData = {"achievements"}
    achievementUnlock = {}
    for i, achievement in pairs(data) do
        table.insert(achievementUnlock, achievement.unlocked)
    end
    table.insert(achievementData, achievementUnlock)
    channel:push(achievementData)
end

function saveReset()
    love.filesystem.remove("save-data.dat")
    love.filesystem.remove("achievement-data.dat")
    saveAchievementData(DEFAULT_ACHIEVEMENTS)
    achievementSystem = AchievementSystem(loadAchievementData())
    print("Resetting saves...")
    for i, achievement in pairs(achievementSystem.achievements) do
        print(achievement.unlocked)
    end
end



function saveData(data)
    thread:start(channel)
    gameData = {"game"}
    table.insert(gameData, data)
    channel:push(gameData)
end

function setColor(color)
    local r, g, b, a = love.graphics.getColor()

    -- research showed setColor lags when overused 
    if r ~= color[1] and g ~= color[2] or b ~= color[3] then 
        love.graphics.setColor(color)
    end
end

function clear(table)
    for i = 1, #table do
        table[i] = nil
    end
end