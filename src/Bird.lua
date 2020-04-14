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
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") and self.y - self.speed * dt > 0 then
		self.y = self.y - self.speed * dt
	end
	if love.keyboard.isDown("s") or love.keyboard.isDown("down") and self.y + self.speed * dt < VIRTUAL_HEIGHT then
		self.y = self.y + self.speed * dt
	end
	if love.keyboard.isDown("a") or love.keyboard.isDown("left") and self.x - self.speed * dt > 0 then
		self.x = self.x - self.speed * dt
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		self.x = self.x + self.speed * dt
	end
	if self.x >= VIRTUAL_WIDTH - self.width then
		self.reachedGoal = true
		self.x = 100
		self.y = VIRTUAL_HEIGHT/2
	end
end

function Bird:render()
	love.graphics.setColor(66, 78, 244, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.width)
end