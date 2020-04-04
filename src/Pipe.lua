Pipe = Class{}

function Pipe:init()
	self.velocity = -125*1.5
	self.width = 50
	self.x = VIRTUAL_WIDTH
	self.y = 0
	self.height = VIRTUAL_HEIGHT
	self.gapY = love.math.random(self.y + 100, self.height - 100)
	self.gapLength = 75

end

function Pipe:update(dt)
	self.x = self.x + self.velocity*dt
end

function Pipe:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.gapY)
	love.graphics.rectangle('fill', self.x, self.gapY + self.gapLength + self.y, self.width, self.height - self.gapY + self.gapLength + self.y)
end