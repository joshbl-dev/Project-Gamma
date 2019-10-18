Clickable = Class{}

function Clickable:init(x, y, width, height, onClick, floorNumber)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.onClick = onClick
    if floorNumber ~= nil then
        self.floorNumber = floorNumber
    else
        self.floorNumber = nil
    end

    self.holding = false

end

function Clickable:update(dt)
    if self.floorNumber == nil or self.floorNumber == currentFloor then
        if self:wasClicked() then
            self:onClick()
        end
        self.holding = self:isHolding()
    end
end


function Clickable:isHovering()
    local x, y = love.mouse.getPosition()
    if x > self.x and x < self.x + self.width and y > self.y and y < self.y + self.height then
        return true
    else
        return false
    end
end

function Clickable:isHolding()
    local x, y = love.mouse.getPosition()
    if self:isHovering() and love.mouse.isDown(1) then
        return true
    else
        return false
    end
end

function Clickable:wasClicked()
    if self:isHovering() and self.holding and not love.mouse.isDown(1) then
        print("true")
        return true
    else
        return false
    end
end
