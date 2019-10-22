-- an upgrade menu is our way of upgrading/buying new elements in the game


UpgradeMenu = Class{}

function UpgradeMenu:init(defs, floorNumber)
    self.x = defs.x
    self.y = defs.y
    self.width = defs.width
    self.height = defs.height
    self.type = defs.type
    self.cost = defs.cost
    self.buttonText = defs.buttonText
    self.buttonWidth = font:getWidth(self.buttonText)
    self.buttonHeight = font:getHeight(self.buttonText)
    self.button = Button({x = self.x + self.width / 2 - self.buttonWidth / 2, y = self.y + self.height / 2 - self.buttonHeight / 2,
                            width = self.buttonWidth * 1.1, height = self.buttonHeight * 1.1, text = self.buttonText, onClick = defs.onClick}, "rect", floorNumber)
    if defs.timer then
        self.timer = defs.timer
        self.clock = Clock(-100, -100, false, 0)
    else
        self.timer = defs.timer
    end
    self.upgrading = false

end

function UpgradeMenu:update(dt)
    -- this is a quality of life upgrade to make the upgrade guis dissappear if they dont need to be permanent
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
        love.graphics.print("$" .. self.cost, self.x + self.width / 2 - font:getWidth("$" .. self.cost) / 2, self.y + self.height - font:getHeight("$" .. self.cost))
        love.graphics.print(self.type, self.x + self.width / 2 - font:getWidth(self.type) / 2, self.y)
    end
end

function UpgradeMenu:purchase()
    -- we use this is do a purchase
    if money >= self.cost then
        self.upgrading = false
        money = money - self.cost
        return true
    end
    return false
end