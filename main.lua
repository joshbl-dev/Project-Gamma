require 'src/Dependencies'

-- size of actual window
WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 600

-- size to emulate with push
<<<<<<< HEAD
VIRTUAL_WIDTH = 430
VIRTUAL_HEIGHT = 243
=======
VIRTUAL_WIDTH = 1000
VIRTUAL_HEIGHT = 600
>>>>>>> 532dcbb7b1dbb8f0074204678e9784b5c719879d



function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Project Gamma')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    stateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end
    }

    stateMachine:change('start')

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
    love.graphics.clear(0, 0, 255)
    stateMachine:render()
	displayFPS()
	push:apply('end')
end

function displayFPS()
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 0, 0)
end
