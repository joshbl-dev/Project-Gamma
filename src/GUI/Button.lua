
Button = Class{}

function Button:init(x, y, width, height, text)
    self.clickable = Clickable(x, y, width, height)
    self.text = text
end

function Button:update(dt)
    self.clickable:update(dt)
end

function Button:render()
    self.clickable:render()
    if self.clickable.hovering then
        if self.clickable.pressed then
            love.graphics.setColor(colors['blue'])
        else
            love.graphics.setColor(colors['black'])
        end
    else
        love.graphics.setColor(colors['gray'])
    end
    love.graphics.rectangle("fill", self.clickable.x, self.clickable.y, self.clickable.width, self.clickable.height)
    love.graphics.setFont(love.graphics.newFont(fonts["papyrus"], 20))
    font = love.graphics.getFont()
    if self.clickable.hovering then
        love.graphics.setColor(colors["white"])
    else
        love.graphics.setColor(colors["black"])
    end
    love.graphics.print(self.text, math.floor(self.clickable.x + self.clickable.width / 2 - font:getWidth(self.text) / 2), math.floor(self.clickable.y + self.clickable.height / 2 - font:getHeight(self.text) / 2))
end