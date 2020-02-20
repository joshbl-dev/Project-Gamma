-- Author: Josh Landsman
-- Email: laxisgood4u@gmail.com

Player = Class{}

function Player:init(x, y)
	self.x = x
	self.y = y
	self.length = 3


	-- -- skills
	-- self.skills = {
 --    	["sight"] = Skill (
 --    		"Sight",
 --    		60,
 --    		VIRTUAL_HEIGHT / 2 - 25,
 --    		25,
 --    		25
 --    	),
 --    	["speed"] = Skill (
 --    		"Speed",
 --    		60,
 --    		VIRTUAL_HEIGHT / 2 + 25,
 --    		25,
 --    		25
 --    	)
 --    }


end

function Player:update(dt)
	-- update each skill
	-- for _, skill in pairs(self.skills) do
	-- 	skill:update(dt)
	-- end


	-- movement
	local speed = PLAYER_SPEED
	-- sprint
	-- if love.keyboard.isDown("lshift") then
	-- 	speed = PLAYER_SPEED * (1 + self.skills["speed"].value / 20)
	-- end
	-- normal movement, only can move in one direction
	if love.keyboard.isDown("w") then
		self.y = self.y - speed * dt
	elseif love.keyboard.isDown("s") then
		self.y = self.y + speed * dt
	elseif love.keyboard.isDown("a") then
		self.x = self.x - speed * dt
	elseif love.keyboard.isDown("d") then
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


		-- gSounds['wall-hit']:play()
		local speed = PLAYER_SPEED
		-- if sprinting adjust
		-- if love.keyboard.isDown("lshift") then
		-- 	speed = PLAYER_SPEED * (1 + self.skills["speed"].value / 20)
		-- end
		-- adjust to previous location
		if love.keyboard.isDown("w") then
			self.y = self.y + speed * dt
		elseif love.keyboard.isDown("s") then
			self.y = self.y - speed * dt
		elseif love.keyboard.isDown("a") then
			self.x = self.x + speed * dt
		elseif love.keyboard.isDown("d") then
			self.x = self.x - speed * dt
		end
	end
end


function Player:render()
	-- for _, skill in pairs(self.skills) do
	-- 	skill:render()
	-- end

	love.graphics.setColor(66, 78, 244, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.length, self.length)
end