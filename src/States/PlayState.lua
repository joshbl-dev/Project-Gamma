PlayState = Class{__includes = BaseState}

function PlayState:init()

	-- we made a floor changer to help organize the floor and changing/rendering them
	self.floorChanger = FloorChanger()

	-- not really a menu 
	self.tempMenu = Button({ x = 0, y = 50, width = 120, height = 50, text = "Menu", onClick = function()
		self:saveFloor()
		stateMachine:change("start")
	end}, "rect")

	-- clock to save automatically and track time played
	self.clock = Clock(VIRTUAL_WIDTH / 2, 0, true, 0)
	self.saveClock = Clock(-100, -100, false, 0)
	money = DEFAULT_GAME_MONEY
end

function PlayState:enter(saveData)
	if not newGame then
		local floors = {}
		for i, floor in pairs(saveData[1]) do
			table.insert(floors, Floor(false, i, floor))
		end
		self.floorChanger:loadSavedFloors(floors)
		money = saveData[2]
		self.clock = Clock(VIRTUAL_WIDTH / 2, 0, true, saveData[3])
	end
	self:saveFloor()
	newGame = false
end

function PlayState:update(dt)
	self.saveClock:update(dt)
	if self.saveClock.minutes > 0 then
		self:saveFloor()
		self.saveClock.time = 0
	end

	-- manual saving
	if love.keyboard.wasReleased("s") and #self.floorChanger.floors > 0 then
		self:saveFloor()
	end

	self.floorChanger:update(dt)
	self.clock:update(dt)
	self.tempMenu:update(dt)
end

function PlayState:render()
	self.floorChanger:render()
	self.clock:render()
	self.tempMenu:render()
	r, g, b, a = love.graphics.getColor()

	-- research showed setColor lags when overused 
	if r ~= 10 and g ~= 9 or b ~= 8 then
		love.graphics.setColor(colors["black"])
	end
	love.graphics.print("Money: $" .. (math.floor(money)), 100, 0)
end

function PlayState:saveFloor()
	-- used for saving the current playstate not really just floor anymore
	local data = {}
	local floorsData = {}
		for i, floor in pairs(self.floorChanger.floors) do
			local floorData = {}
			for j, row in pairs(floor.grid.cells) do
				for i, cell in pairs(row) do
					table.insert(floorData, cell:getData()) -- insert worker into workerData table (containing all workers on the floor)
			end
		end
		table.insert(floorsData, floorData)
	end
		table.insert(data, floorsData)
		table.insert(data, money)
		table.insert(data, self.clock.time)
		saveData(data)
end