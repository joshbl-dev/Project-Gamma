Cubicle = Class{}

function Cubicle:init(defs)
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.worker = Worker(defs)
	self.price = DEFAULT_CUB
	self.purchased = defs.worker[1]
end

function Cubicle:update(dt)
	if self.purchased then
		self.worker:update(dt)
	end
end

function Cubicle:render()
	if self.purchased then
		self.worker:render()
	end
	love.graphics.setColor(colors["purple"])
	love.graphics.rectangle("fill", self.x, self.y, self.width * .25, self.height * .75)
end

function Cubicle:buyWorker()
	self.purchased = true
end

function Cubicle:hasWorker()
	if self.purchased then
		return true
	else
		return false
	end
end