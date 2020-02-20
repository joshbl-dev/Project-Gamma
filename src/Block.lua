-- Author: Josh Landsman
-- Email: laxisgood4u@gmail.com

Block = Class{}

function Block:init(row, col)
	self.row = row
	self.col = col
	self.hasLadder = false
	self.hasToken = false

	-- coords
	self.x = {(row - 1) * WALL_LENGTH + ROW_OFFSET, 
				row * WALL_LENGTH + ROW_OFFSET}
	self.y = {(col - 1) * WALL_LENGTH + COL_OFFSET, 
				col * WALL_LENGTH + COL_OFFSET}


	-- sides
	self.walls = {["N"] = Wall(self.x[1], self.y[1], self.x[2], self.y[1]),
				["S"] = Wall(self.x[1], self.y[2], self.x[2], self.y[2]),
				["E"] = Wall(self.x[2], self.y[1], self.x[2], self.y[2]),
				["W"] = Wall(self.x[1], self.y[1], self.x[1], self.y[2])
	}
end


function Block:collided(player)

	-- FUN AABB COLLISION DETECTION COMPARED TO THE LINE COLLISION DETECTION

	if self.x[1] + 3 > player.x + player.length or player.x > self.x[2] - 3 then
        return false
    end

    if self.y[1] + 3 > player.y + player.length or player.y > self.y[2] - 3 then
        return false
    end 

    return true

end


function Block:render()

	-- ladder
	if self.hasLadder then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.circle("line", self.x[2] - WALL_LENGTH / 2, self.y[2] - WALL_LENGTH / 2, 2)
	end

	-- token
	if self.hasToken then
		love.graphics.setColor(242, 205, 43, 255)
		love.graphics.circle("fill", self.x[2] - WALL_LENGTH / 2, self.y[2] - WALL_LENGTH / 2, 2)
	end


	-- walls
	for _, wall in pairs(self.walls) do
		if (wall) then
			love.graphics.setColor(100, 100, 100, 255)
			wall:render()
		end
	end
end