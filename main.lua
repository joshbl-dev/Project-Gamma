require 'src/Dependencies'

-- size of actual window
WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 600

-- size to emulate with push

VIRTUAL_WIDTH = 1000
VIRTUAL_HEIGHT = 600

-- current font being used

currFont = fonts["papyrus"]

-- variables used in-game

money = 2100 --money throughout game, starts at 2100
month = 0 --once month reaches 12 it loops back to 0
day = 0 --once day reaches 30, set day to 0 and increment month by 1
hours = 0 --once hour reaches 24, set hour to 0 and increment day by 1
minutes = 0 --once minutes reaches 60, set minutes to 0 and increment hours by 1


local time = 0


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
	time = time + dt
	local temp = time/(6.9*math.pow(10,-5))
	month = math.floor(temp/(30 * 24 * 3600))
	temp = temp % (30 * 24 * 3600)
	day = math.floor(temp/(24 * 3600))
	temp = temp % (24 * 3600)
	hours = math.floor(temp/(3600))
	temp = temp % 3600
	minutes = math.floor(temp/60)
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
    love.graphics.print('Month: ' .. month .. ' Day: ' .. day .. ' Hour: ' .. hours .. ' Minute: ' .. minutes, 100, 0)
end


