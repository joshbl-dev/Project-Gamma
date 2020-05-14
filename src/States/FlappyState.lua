FlappyState = Class{__includes = BaseState}

function FlappyState:init()
	self.pipes = {}
	self.maxPipes = nil
	self.bird = Bird()
	self.popup = Popup("Make it to the right side of the screen\nwithout touching the bars. Use WASD or\nthe arrow keys to move. The number of\nbars corresponds to the level of the\nworker times 3.")
end

function FlappyState:enter(params)
	if params.playState ~= nil then
		self.playState = params.playState
		print("Saved play state")
	end
	if params.workerLevel ~= nil then
		self.maxPipes = (params.workerLevel + 1) * 3
	end

end

function FlappyState:update(dt)
	if love.keyboard.isDown("9") then
		self.playState:saveFloor()
		stateMachine.current = self.playState
	end
	if self.popup.pushed == true then
		if #self.pipes == 0 or self.pipes[#self.pipes].x <= VIRTUAL_WIDTH - 200 and #self.pipes < self.maxPipes then
			self.pipes[#self.pipes + 1] = Pipe()
		end
		for i in pairs(self.pipes) do
			if self.pipes[i].x > 0 - self.pipes[i].width then
				self.pipes[i]:update(dt)
			end
		end
		self.bird:update(dt)
		if self.bird.reachedGoal then
			self.playState:saveFloor()
			stateMachine.current = self.playState
		end
		if self:touching() then
			stateMachine:change('flappy', {playState = self.playState, workerLevel = self.maxPipes/3 - 1})
		end
	else
		self.popup:update(dt)
	end
end

function FlappyState:render()
	
	love.graphics.clear(40, 45, 52, 255)
	for i in pairs(self.pipes) do
		if self.pipes[i].x > 0 - self.pipes[i].width then
			self.pipes[i]:render()
		end
	end
	self.bird:render()
	if self.popup.pushed == false then
		self.popup:render()
	end
end

function FlappyState:touching()
	for i in pairs(self.pipes) do
		if (self.bird.x > self.pipes[i].x and self.bird.x < self.pipes[i].x + self.pipes[i].width) and 
		  ((self.bird.y > self.pipes[i].y and self.bird.y < self.pipes[i].gapY) or
		  (self.bird.y > self.pipes[i].gapY + self.pipes[i].gapLength and self.bird.y < self.pipes[i].height)) then
		  	return true
		end
		if (self.bird.x + self.bird.width > self.pipes[i].x and self.bird.x + self.bird.width < self.pipes[i].x + self.pipes[i].width) and 
		  ((self.bird.y + self.bird.width > self.pipes[i].y and self.bird.y + self.bird.width < self.pipes[i].gapY) or
		  (self.bird.y + self.bird.width > self.pipes[i].gapY + self.pipes[i].gapLength and self.bird.y + self.bird.width < self.pipes[i].height)) then
		  	return true
		end
	end
	return false
end

