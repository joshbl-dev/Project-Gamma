Bird = Class{}

function Bird:init()
	self.x = 100
	self.y = VIRTUAL_HEIGHT/2
	self.speed = 125*1.5
	self.width = 15
	self.reachedGoal = false
end

function Bird:update(dt)
	-- movement
	-- normal movement, only can move in one direction
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		self.y = self.y - self.speed * dt
	end
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		self.y = self.y + self.speed * dt
	end
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		self.x = self.x - self.speed * dt
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		self.x = self.x + self.speed * dt
	end
	if self.x >= VIRTUAL_WIDTH then
		self.reachedGoal = true
		self.x = 100
		self.y = VIRTUAL_HEIGHT/2
	end
end

function Bird:render()
	love.graphics.setColor(66, 78, 244, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.width)
end