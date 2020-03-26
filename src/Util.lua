function displayFPS()
    setColor(colors['black'])
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 0, 0)
end

-- loads game data
function loadData()
    -- using the bitser library data is serialized for and deserialized for easy storage
    if love.filesystem.exists('save-data.dat') then
        return bitser.loadLoveFile('save-data.dat')
    else
        newGame = true
    end
end

-- loads achievement data into game
function loadAchievementData()
    if love.filesystem.exists('achievement-data.dat') then
        return bitser.loadLoveFile('achievement-data.dat')
    end
    return false
end

-- saves achievement data to achievement file
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

-- resets ALL data
function saveReset()
    love.filesystem.remove("save-data.dat")
    love.filesystem.remove("achievement-data.dat")
    achievementSystem:reset()
    saveAchievementData(achievementSystem.achievements)
    print("Resetting saves...\n\n")
end

-- saves game data
function saveData(data)
    thread:start(channel)
    gameData = {"game"}
    table.insert(gameData, data)
    channel:push(gameData)
end

-- helper functions
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

-- scrolling
function love.wheelmoved(x, y)
    if y > 0 then
        velY = velY - 75
    elseif y < 0 then
        velY = velY + 75
    end
end

function GenerateGrid(index1, index2)
    local maze = {}

    local maxTokens = math.random(3, 5)
    local tokenCount = 0
    
    for i = 0, GRID_LENGTH do
        maze[i + 1] = {}
        for j = 0, GRID_LENGTH do
            maze[i + 1][j + 1] = Block(i, j)

            -- generate tokens
            if math.random() < 0.01 and tokenCount < maxTokens then
                maze[i + 1][j + 1].hasToken = true
                tokenCount = tokenCount + 1
            end

        end
    end

    -- generate goal
    ladderX = index1
    ladderY = index2
    maze[index1][index2].hasLadder = true

    return maze, tokenCount
end

function carveMaze(maze)
    -- first index represents the East or West side
    -- second index represents the North or South side
    -- maybe...

    -- maze bias
    local trash math.random(#DIRECTIONS)
    local possibleDirs = DIRECTIONS[math.random(#DIRECTIONS)]

    -- Remove diagonol biased walls
        for i = 1, #maze - 1 do

            -- SE
            if possibleDirs[1] == "S" and possibleDirs[2] == "E" then
                maze[i][#maze].walls["E"] = nil
                maze[i + 1][#maze].walls["W"] = nil

                maze[#maze][i].walls["S"] = nil
                maze[#maze][i + 1].walls["N"] = nil
            end

            -- SW
            if possibleDirs[1] == "S" and possibleDirs[2] == "W" then
                maze[i][#maze].walls["E"] = nil
                maze[i + 1][#maze].walls["W"] = nil

                maze[1][i].walls["S"] = nil
                maze[1][i + 1].walls["N"] = nil
            end

            -- NE
            if possibleDirs[1] == "N" and possibleDirs[2] == "E" then
                maze[i][1].walls["E"] = nil
                maze[i + 1][1].walls["W"] = nil

                maze[#maze][i].walls["S"] = nil
                maze[#maze][i + 1].walls["N"] = nil
            end

            -- NW
            if possibleDirs[1] == "N" and possibleDirs[2] == "W" then
                maze[i][1].walls["E"] = nil
                maze[i + 1][1].walls["W"] = nil

                maze[1][i].walls["S"] = nil
                maze[1][i + 1].walls["N"] = nil
            end


        end


    for i, col in pairs(maze) do
        for j, row in pairs(maze[i]) do

            local currentBlock = maze[i][j]

            --  gets next carve
            local nextDir = possibleDirs[math.random(#possibleDirs)]

            if j > 1 and nextDir == "N" then
                currentBlock.walls["N"] = nil
                maze[i][j - 1].walls["S"] = nil
            end
            if j < GRID_LENGTH + 1 and nextDir == "S" then
                currentBlock.walls["S"] = nil
                maze[i][j + 1].walls["N"] = nil
            end
            if i > 1 and nextDir == "W" then
                currentBlock.walls["W"] = nil
                maze[i - 1][j].walls["E"] = nil
            end
            if i < GRID_LENGTH + 1 and nextDir == "E" then
                currentBlock.walls["E"] = nil
                maze[i + 1][j].walls["W"] = nil
            end
        end
    end

    return maze
end

function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end


