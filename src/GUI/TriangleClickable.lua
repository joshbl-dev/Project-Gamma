-- this is a triangle clickable since it is created differently than a square

TriangleClickable = Class{}

function TriangleClickable:init(verticies, onClick, floorNumber)
    self.verticies = verticies
    self.area = math.abs((self.verticies[2][1] - self.verticies[1][1])*(self.verticies[3][2] - self.verticies[1][2]) - (self.verticies[3][1] - self.verticies[1][1])*(self.verticies[2][2] - self.verticies[1][2]))
    if floorNumber ~= nil then
        self.floorNumber = floorNumber
    else
        self.floorNumber = nil
    end
    self.onClick = onClick

    self.holding = false

end

function TriangleClickable:update(dt)
    if self.floorNumber == nil or self.floorNumber == currentFloor then
        if self:wasClicked() then
            self:onClick()
        end
        self.holding = self:isHolding()
    end
end


function TriangleClickable:isHovering()
    local x, y = love.mouse.getPosition()
    if x ~= nil and y ~= nil then

        -- research showed this is the best way to do triangle collision detection
        area1 = math.abs((self.verticies[1][1] - x)*(self.verticies[2][2] - y) - (self.verticies[2][1] - x)*(self.verticies[1][2] - y))
        area2 = math.abs((self.verticies[2][1] - x)*(self.verticies[3][2] - y) - (self.verticies[3][1] - x)*(self.verticies[2][2] - y))
        area3 = math.abs((self.verticies[3][1] - x)*(self.verticies[1][2] - y) - (self.verticies[1][1] - x)*(self.verticies[3][2] - y))

        if (area1 + area2 + area3 == self.area) then
            return true
        end
    end
    return false
end

function TriangleClickable:isHolding()
    local x, y = love.mouse.getPosition()
    if self:isHovering() and love.mouse.isDown(1) then
        return true
    else
        return false
    end
end

function TriangleClickable:wasClicked()
    if self:isHovering() and self.holding and not love.mouse.isDown(1) then
        print("true")
        return true
    else
        return false
    end
end
