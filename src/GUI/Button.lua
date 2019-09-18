
Button = Class{}

function Button:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.pressed = false
    self.hovering = false

end

function Button:update(dt)
    local x, y = love.mouse.getPosition()
    if x > self.x and x < self.x + self.width and y > self.y and y < self.y + self.height then
        if love.mouse.isDown(1) then
            self.pressed = true
        else
            self.pressed = false
        end
        self.hovering = true
    else
        self.hovering = false
    end

end

function Button:render()
    if self.hovering then
        if self.pressed then
            love.graphics.setColor(colors['blue'])
        else
            love.graphics.setColor(colors['black'])
        end
    else
        love.graphics.setColor(colors['gray'])
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end


