-- Author: Josh Landsman
-- Email: laxisgood4u@gmail.com

MazeState = Class{__includes = BaseState}

function MazeState:init()

	-- initial data to prevent nil values
	self.data = {level = 0,
					row = math.random(GRID_LENGTH),
					col = math.random(GRID_LENGTH),
					tokens = 0}

	-- tokens found on current level
    self.tokensLevelCount = 0


    -- maze generation
	self.maze, self.maxTokens = GenerateGrid(self.data.row, self.data.col)
	self.maze = carveMaze(self.maze)

	-- dafault player
	self.player = Player(ROW_OFFSET - WALL_LENGTH / 2, COL_OFFSET - WALL_LENGTH / 2)

end

function MazeState:enter(params)
	if (params.playState ~= nil) then
		self.playState = params.playState
		print("Saved play state")
	end

	-- -- updates the stuff on level change
	-- self.data = params

	-- if self.data.level > 1 then
	-- 	self.player = Player((self.data.row - 1) * WALL_LENGTH + ROW_OFFSET - WALL_LENGTH / 2, (self.data.col - 1) * WALL_LENGTH + COL_OFFSET - WALL_LENGTH / 2)
	-- end

	-- self.player.skills["sight"].value = self.data.sight
	-- self.player.skills["speed"].value = self.data.speed

end

function MazeState:update(dt)

	-- local dataChanged = false

	-- debugging keycombo
	if love.keyboard.isDown("=") and love.keyboard.isDown("-") and not DEPLOYED then
		DEBUGGING = not DEBUGGING
		-- prevent double click
		love.timer.sleep(.2)
	end 

	if love.keyboard.isDown("[") and DEBUGGING then
		self.data.tokens = self.data.tokens + 1
		-- prevent double click
		love.timer.sleep(.2)
		-- dataChanged = true
	end 

	-- updates
	-- self.menu:update(dt)
	self.player:update(dt)


	-- token functionality
	-- if self.data.tokens > 0 then
	-- 	for _, skillButton in pairs(self.player.skills) do

	-- 		-- check if button clicked and increment values
	-- 		if skillButton.button:isClicked() and skillButton.value < 20 then
	-- 			self.data.tokens = self.data.tokens - 1
	-- 			skillButton.value = skillButton.value + 1
	-- 			if skillButton.type == "Sight" then
	-- 				self.data.sight = self.data.sight + 1
	-- 			elseif skillButton.type == "Speed" then
	-- 				self.data.speed = self.data.speed + 1
	-- 			end
	-- 			dataChanged = true
	-- 			-- prevent double click
	-- 			love.timer.sleep(.2)
	-- 		end
	-- 	end
	-- else
	-- 	for _, skillButton in pairs(self.player.skills) do
	-- 		skillButton.button.cursor = {244, 66, 98}
	-- 	end
	-- end

	if love.keyboard.isDown("8") and not DEPLOYED then
		self.playState:saveFloor()
		print(#self.playState.floorChanger.floors)
		stateMachine.current = self.playState
	end 

	-- collisions
	for i, row in pairs(self.maze) do
		for j, col in pairs(self.maze[i]) do

			-- next level progression
			if self.maze[i][j].hasLadder and self.maze[i][j]:collided(self.player) then
				-- gSounds['door']:play()

				-- self.data.level = self.data.level + 1
				-- saveData(self.data)
				self.playState:saveFloor()
				print(#self.playState.floorChanger.floors)
				stateMachine.current = self.playState
			end

			-- token collision and updates
			if self.maze[i][j].hasToken and self.maze[i][j]:collided(self.player) then
				self.maze[i][j].hasToken = false
				-- gSounds['pickup']:play()
				-- self.data.tokens = self.data.tokens + 1
				self.tokensLevelCount = self.tokensLevelCount + 1
				-- dataChanged = true
			end

			-- wall collision
			for k, wall in pairs(self.maze[i][j].walls) do
				self.player:collidesWithWall(wall, dt)
			end
		end
	end

	-- only update data if a change was made to relevant variables
	-- if dataChanged then
	-- 	saveData(self.data)
	-- end

end

function MazeState:render()

	love.graphics.clear(40, 45, 52, 255)

	-- renders
	-- self.menu:render()
	self.player:render()
	self.maze[ladderX][ladderY]:render()

	-- Logo
    -- love.graphics.setFont(gFonts["medium"])
    -- love.graphics.setColor(255, 255, 255, 255)
    -- love.graphics.draw(gTextures['logo'], 135, VIRTUAL_HEIGHT - 35, 0, .5, .5)
    -- love.graphics.setColor(79, 24, 219,255)
    -- love.graphics.print("Hidden Paths", 20, VIRTUAL_HEIGHT - 30)
	
    -- love.graphics.setColor(79, 24, 219,255)
    -- love.graphics.setFont(gFonts["medium"])

    -- Goal Legend
    love.graphics.setColor(79, 24, 219,255)
	love.graphics.print("Goal: ", VIRTUAL_WIDTH / 2 + WALL_LENGTH * GRID_LENGTH / 2 + 50, VIRTUAL_HEIGHT - 50)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.circle("line", VIRTUAL_WIDTH / 2 + WALL_LENGTH * GRID_LENGTH / 2 + 95, VIRTUAL_HEIGHT - 42, 2)
	

	-- Token legend
	love.graphics.setColor(79, 24, 219,255)
    love.graphics.print("Tokens: ", VIRTUAL_WIDTH / 2 + WALL_LENGTH * GRID_LENGTH / 2 + 50, VIRTUAL_HEIGHT - 30)
    love.graphics.setColor(242, 205, 43, 255)
	love.graphics.circle("fill", VIRTUAL_WIDTH / 2 + WALL_LENGTH * GRID_LENGTH / 2 + 120, VIRTUAL_HEIGHT - 22, 2)



	-- Token and Level count
	love.graphics.setColor(79, 24, 219,255)
    -- love.graphics.print("Level: " .. tostring(self.data.level), VIRTUAL_WIDTH / 2 - 50, 20)
    love.graphics.print("Tokens Found: " .. tostring(self.tokensLevelCount) .. " / " .. tostring(self.maxTokens), 
    					VIRTUAL_WIDTH / 2 - 100, 35)

    -- total tokens
    -- love.graphics.print("Tokens: " .. tostring(self.data.tokens), 100, VIRTUAL_HEIGHT / 2 - 20)

    -- maze sight
	if not DEBUGGING then
		love.graphics.stencil(function()
		    love.graphics.circle('fill', self.player.x, self.player.y, 20 * MAZE_SCALE_RATIO) 

			end, 'replace', 2)

		love.graphics.setStencilTest('greater', 1)
	end

	-- maze render
    for i, row in pairs(self.maze) do
		for j, col in pairs(self.maze[i]) do
			self.maze[i][j]:render()
		end
	end

    love.graphics.setStencilTest()

    -- border
    love.graphics.rectangle("line", ROW_OFFSET - WALL_LENGTH, COL_OFFSET - WALL_LENGTH, (GRID_LENGTH + 1) * WALL_LENGTH, (GRID_LENGTH + 1) * WALL_LENGTH)



end