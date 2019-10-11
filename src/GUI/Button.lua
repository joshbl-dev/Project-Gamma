
Button = Class{}

function Button:init(x, y, width, height, text, onClick)
    self.clickable = Clickable(x, y, width, height, onClick)

    self.text = text
    self.textColor = "black"
    self.buttonColor = "gray"
end

function Button:update(dt)
    self.clickable:update(dt)

    if self.clickable:wasClicked() then
        self.buttonColor = "blue"
    elseif self.clickable:isHovering() then
        self.buttonColor = "black"
    else
        self.buttonColor = "gray"
    end


    if self.clickable:isHovering() then
        self.textColor = "white"
    else
        self.textColor = "black"
    end

end

function Button:render()
    love.graphics.setColor(colors[self.buttonColor])
    love.graphics.rectangle("fill", self.clickable.x, self.clickable.y, self.clickable.width, self.clickable.height)
    love.graphics.setFont(love.graphics.newFont(currFont, 20))
    font = love.graphics.getFont()
    love.graphics.setColor(colors[self.textColor])
    love.graphics.print(self.text, math.floor(self.clickable.x + self.clickable.width / 2 - font:getWidth(self.text) / 2), math.floor(self.clickable.y + self.clickable.height / 2 - font:getHeight(self.text) / 2))
end