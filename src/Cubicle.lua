Cubicle = Class{}

function Cubicle:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.worker = Worker()
	if defs.worker then
		buyWorker()
	end
end

function Cubicle:update(dt)
	if self.worker.bought then
		self.worker:update(dt)
	end
end

function Cubicle:render()
	if self.worker.bought then
		self.worker:render()
	end
	love.graphics.setColor(colors["purple"])
	love.graphics.rectangle("fill", self.x, self.y, self.width * .25, self.height * .75)
end

function Cubicle:buyWorker()
	self.worker = Worker({x = self.x, y = self.y, width = self.width, height = self.height})
	self.worker.bought = true
end