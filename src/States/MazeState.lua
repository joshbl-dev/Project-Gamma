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
end

function MazeState:update(dt)
	-- debugging keycombo
	-- if love.keyboard.isDown("=") and love.keyboard.isDown("-") and not DEPLOYED then
	-- 	DEBUGGING = not DEBUGGING
	-- 	-- prevent double click
	-- 	love.timer.sleep(.2)
	-- end 

	-- if love.keyboard.isDown("[") and DEBUGGING then
	-- 	self.data.tokens = self.data.tokens + 1
	-- 	-- prevent double click
	-- 	love.timer.sleep(.2)
	-- end 

	-- updates
	self.player:update(dt)

	-- if love.keyboard.isDown("8") and not DEPLOYED then
	-- 	self.playState:saveFloor()
	-- 	print(#self.playState.floorChanger.floors)
	-- 	stateMachine.current = self.playState
	-- end 

	-- collisions
	for i, row in pairs(self.maze) do
		for j, col in pairs(self.maze[i]) do

			-- next level progression
			if self.maze[i][j].hasLadder and self.maze[i][j]:collided(self.player) then

				self.playState:saveFloor()
				print(#self.playState.floorChanger.floors)
				stateMachine.current = self.playState
			end

			-- token collision and updates
			if self.maze[i][j].hasToken and self.maze[i][j]:collided(self.player) then
				self.maze[i][j].hasToken = false
				self.tokensLevelCount = self.tokensLevelCount + 1
			end

			-- wall collision
			for k, wall in pairs(self.maze[i][j].walls) do
				self.player:collidesWithWall(wall, dt)
			end
		end
	end

end

function MazeState:render()

	love.graphics.clear(40, 45, 52, 255)

	-- renders
	self.player:render()
	self.maze[ladderX][ladderY]:render()

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