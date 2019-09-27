Cubicle = Class{}

function Cubicle:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.worker = Worker(defs)
end

function Cubicle:update(dt)
	self.worker:update(dt)
end

function Cubicle:render()
	self.worker:render()
	love.graphics.setColor(colors["purple"])
	love.graphics.rectangle("fill", self.x, self.y, self.width * .25, self.height * .75)
end