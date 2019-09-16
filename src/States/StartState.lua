StartState = Class{__includes = BaseState}

function StartState:init()

end

function StartState:update()
end

function StartState:render()
	love.graphics.setColor(255, 0, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), VIRTUAL_WIDTH / 2, 0)
end




