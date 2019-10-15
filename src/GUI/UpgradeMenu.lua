
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
                            self.buttonWidth * 1.1, self.buttonHeight * 1.1, self.buttonText, defs.onClick)
    if defs.timer then
        self.timer = defs.timer
        self.clock = Clock(-100, -100, false, 0)
    else
        self.timer = defs.timer
    end
    self.upgrading = false

end

function UpgradeMenu:update(dt)
    if self.upgrading then
        if self.timer then
            self.clock:update(dt)
            if self.clock.time / 60 > 5/60 then
                self.clock.time = 0
                self.upgrading = false
            end
        end
        self.button:update(dt)
    end
end

function UpgradeMenu:render()
    if self.upgrading then
        self.button:render()
        love.graphics.setColor(colors["black"])
        love.graphics.print("$" .. self.cost, self.x, self.y + self.height - font:getHeight("$" .. self.cost))
        love.graphics.print(self.type, self.x + self.width / 2 - font:getWidth(self.type) / 2, self.y)
    end
end

function UpgradeMenu:purchase()
    if money >= self.cost then
        self.upgrading = false
        money = money - self.cost
        return true
    end
    return false
end