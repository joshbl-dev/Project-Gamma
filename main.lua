require 'src/Dependencies'

-- size of actual window
WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 600

-- size to emulate with push

VIRTUAL_WIDTH = 1000
VIRTUAL_HEIGHT = 600

-- current font being used

currFont = fonts["skia"]



function love.load()
    -- threas are used to isolate tasking things
    thread = love.thread.newThread("save_thread.lua")
    channel = love.thread.newChannel()



	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Project Gamma')

    -- used to emualte the size changes
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- used to run seperate parts of the game
    stateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['settings'] = function() return SettingsState() end,
        ['achievment'] = function() return AchievementState() end
    }

    stateMachine:change('start')

    data = loadData()
    achievementSystem = AchievementSystem(DEFAULT_ACHIEVEMENTS)
    if (data and data[5]) then
        local count = 1
        for i, achievement in pairs(achievementSystem.achievements) do
            achievement.unlocked = data[5][count]
            print(achievement.unlocked)
            count = count + 1
        end
    end
    -- if (loadData()[5] ~= nil) then
    --     achievements = loadData()[5]
    --     print(achievements.unlocked)
    --     -- for i, achievment in pairs(achievementSystem.achievments) do
    --     --     print(i)
    --     --     print(achievment.unlocked)
    --     -- end
    -- end
    -- achievementSystem:addToQueue("test")
    -- achievementSystem:addToQueue("test 2")

    -- saves last frames key actions
    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}

    love.filesystem.setIdentity("Project-Gamma")
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

function love.keyboard.wasReleased(key)
    return love.keyboard.keysReleased[key]
end

function love.update(dt)
    stateMachine:update(dt)
    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end

function love.draw()
	push:apply('start')
    -- clears the screen white
    love.graphics.clear(colors['white'])
    stateMachine:render()
	displayFPS()
	push:apply('end')
end