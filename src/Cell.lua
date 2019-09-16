Cell = Class{}

function Cell:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
end

function Cell:update(dt)
end

function Cell:render()
	love.graphics.setColor(100, 100, 100, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end