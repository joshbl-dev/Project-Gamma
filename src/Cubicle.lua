Cubicle = Class{}

function Cubicle:init(defs)--set cubicle to saved value or default, whatever is passed through in defs
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.worker = Worker(defs)
	self.price = DEFAULT_CUB * (math.pow(1.5, defs.floorNum - 1))
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
	love.graphics.setColor(colors["purple"])--make desk
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