require 'src/Dependencies'

-- size of actual window
WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 600

-- size to emulate with push

VIRTUAL_WIDTH = 1000
VIRTUAL_HEIGHT = 600

-- current font being used

currFont = fonts["papyrus"]



function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Project Gamma')



	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    stateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['settings'] = function() return SettingsState() end
    }

    stateMachine:change('start')

    love.keyboard.keysPressed = {}

    love.filesystem.setIdentity("Project-Gamma")

    --love.filesystem.remove("save-data.dat")
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

function love.update(dt)
    stateMachine:update(dt)
end

function love.draw()
	push:apply('start')
    love.graphics.clear(colors['white'])
    stateMachine:render()
	displayFPS()
	push:apply('end')
end

function displayFPS()
    love.graphics.setColor(colors['black'])
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 0, 0)
end

function loadData()
    if not love.filesystem.exists('save-data.dat') then
        saveReset()
    else
        return bitser.loadLoveFile('save-data.dat')
    end
end

function saveData(data)
    bitser.dumpLoveFile('save-data.dat', data)
end

function saveReset()
    love.filesystem.remove("save-data.dat")
    saveData("")
    newGame = true
    print("New Game")
end