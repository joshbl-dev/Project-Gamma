Player = Class{}

function Player:init(x, y)
	self.x = x
	self.y = y
	self.length = 3 * MAZE_SCALE_RATIO


	-- -- skills
	self.skills = {
    	["speed"] = 30
    }


end

function Player:update(dt)
	
	-- movement
	local speed = PLAYER_SPEED
	-- sprint
	if love.keyboard.isDown("lshift") then
		speed = PLAYER_SPEED * (1 + self.skills["speed"] / 20)
	end
	-- normal movement, only can move in one direction
	if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		self.y = self.y - speed * dt
	elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		self.y = self.y + speed * dt
	elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
		self.x = self.x - speed * dt
	elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		self.x = self.x + speed * dt
	end

end

function Player:collidesWithWall(wall, dt)
		-- this collision detection is a bit wacc
		-- checks vertical walls
	if (self.x + self.length + 1 >= wall.line[1][1] and self.x <= wall.line[1][1]
		and self.y + self.length <= wall.line[2][2] and self.y >= wall.line[1][2]) or

		-- checks horzontal walls
		(self.x + self.length >= wall.line[1][1] and self.x <= wall.line[2][1]
		and self.y <= wall.line[1][2] and self.y + self.length + 1 >= wall.line[1][2]) or

		-- checks a edge case for vertical walls
		(self.x + self.length + 1 >= wall.line[1][1] and self.x <= wall.line[1][1] 
		and self.y <= wall.line[2][2] and self.y + self.length >= wall.line[1][2])
		
		then

		local speed = PLAYER_SPEED
		-- if sprinting adjust
		if love.keyboard.isDown("lshift") then
			speed = PLAYER_SPEED * (1 + self.skills["speed"] / 20)
		end
		-- adjust to previous location
		if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
			self.y = self.y + speed * dt
		elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
			self.y = self.y - speed * dt
		elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
			self.x = self.x + speed * dt
		elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
			self.x = self.x - speed * dt
		end
	end
end


function Player:render()

	love.graphics.setColor(66, 78, 244, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.length, self.length)
end