Cubicle = Class{}

function Cubicle:init(defs)--set cubicle to saved value or default, whatever is passed through in defs
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.worker = Worker(defs)

	self.rotation = 0
	if (defs.cellNum % 4 == 1 or defs.cellNum % 4 == 3) then
		self.rotation = 3*math.pi/2
		self.y = self.y + self.height
	elseif (defs.cellNum % 4 == 2 or defs.cellNum % 4 == 0) then
		self.rotation = math.pi/2
		self.x = self.x + self.width
	end

	-- ensures randomization
	local trash = math.random(DEFAULT_CUB * (math.pow(4, defs.floorNum - 1)), (DEFAULT_CUB * (math.pow(4, defs.floorNum - 1))) * math.pow(1.1, defs.floorNum))
	if (defs.worker[3]) then
		self.price = defs.worker[3]
	else
		self.price = math.floor(math.random(DEFAULT_CUB * (math.pow(4, defs.floorNum - 1)), (DEFAULT_CUB * (math.pow(4, defs.floorNum - 1))) * math.pow(1.1, defs.floorNum)))
	end
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
	-- setColor(colors["purple"])--make desk
	-- love.graphics.rectangle("fill", self.x, self.y, self.width * .25, self.height * .75)
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.draw(graphics["cubicle"], self.x, self.y, self.rotation)
end

function Cubicle:buyWorker()
	self.purchased = true
	cubiclesOwned = cubiclesOwned + 1
end

function Cubicle:hasWorker()
	if self.purchased then
		return true
	else
		return false
	end
end