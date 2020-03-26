Cubicle = Class{}

function Cubicle:init(defs)--set cubicle to saved value or default, whatever is passed through in defs
	self.x = defs.x
	self.y = defs.y
	self.width = defs.width
	self.height = defs.height
	self.worker = Worker(defs)
	self.floorNum = defs.floorNum
	self.spriteIndex = defs.data[4]

	-- ensures randomization
	local trash = math.random(DEFAULT_CUB * (math.pow(4, defs.floorNum - 1)), (DEFAULT_CUB * (math.pow(4, defs.floorNum - 1))) * math.pow(1.1, defs.floorNum))
	if (defs.data[3]) then
		self.price = defs.data[3]
	else
		self.price = math.floor(math.random(DEFAULT_CUB * (math.pow(4, defs.floorNum - 1)), (DEFAULT_CUB * (math.pow(4, defs.floorNum - 1))) * math.pow(1.1, defs.floorNum)))
	end
	self.purchased = defs.data[1]
end

function Cubicle:update(dt)
	if self.purchased then
		self.worker:update(dt)
	end
end

function Cubicle:render()
	love.graphics.setColor(colors["white"])
	if self.purchased then
		love.graphics.draw(graphics["desk_spritesheet"], spriteTiles["cubicles"][self.spriteIndex], self.x, self.y)
		self.worker:render()
	else
		love.graphics.draw(graphics["desk_spritesheet"], spriteTiles["cubicles"][1], self.x, self.y)
	end

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