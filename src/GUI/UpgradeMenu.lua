
UpgradeMenu = Class{}

function UpgradeMenu:init(defs)
    self.x = defs.x
    self.y = defs.y
    self.width = defs.width
    self.height = defs.height
    self.type = defs.type
    self.cost = defs.cost
    self.buttonText = defs.buttonText
    self.buttonWidth = font:getWidth(self.buttonText)
    self.buttonHeight = font:getHeight(self.buttonText)
    self.button = Button(self.x + self.width - self.buttonWidth * 1.2, self.y + self.height - self.buttonHeight * 1.2,
                            self.buttonWidth * 1.1, self.buttonHeight * 1.1, self.buttonText)
end

function UpgradeMenu:update(dt)
    self.button:update(dt)

end

function UpgradeMenu:render()
    self.button:render()
    love.graphics.print(self.type, self.x + self.width / 2 - font:getWidth(self.type) / 2, self.y + font:getHeight(self.type))
end