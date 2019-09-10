require 'src/Dependencies'

-- size of actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243



function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle('Project Gamma')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
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
end

function love.draw()
	push:apply('start')
	displayFPS()
	push:apply('end')
end

function displayFPS()
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
