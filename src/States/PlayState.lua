PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.floors = {Floor(true, 1)}
	self.tempMenu = Button(0, 50, 120, 50, "Menu", function()
		self:saveFloor()
		stateMachine:change("start")
	end)
	self.clock = Clock(VIRTUAL_WIDTH / 2, 0, true, 0)
	self.saveClock = Clock(-100, -100, false, 0)
	money = DEFAULT_GAME_MONEY
end

function PlayState:enter(saveData)
	if not newGame then
		self.floors = {}
		for i, floor in pairs(saveData[1]) do
			table.insert(self.floors, Floor(false, i, floor))
		end
		money = saveData[2]
		self.clock = Clock(VIRTUAL_WIDTH / 2, 0, true, saveData[3])
	end
	self:saveFloor()
	newGame = false
end

function PlayState:update(dt)
	for i, floor in pairs(self.floors) do
		floor:update(dt)
	end
	self.saveClock:update(dt)
	if self.saveClock.minutes > 0 then
		self:saveFloor()
		self.saveClock.time = 0
	end

	if love.keyboard.wasPressed("s") then
		local floorsData = {}
		for i, floor in pairs(self.floors) do
			floor:update(dt)
			local floorData = {}
			for j, row in pairs(floor.grid.cells) do
				for i, cell in pairs(row) do
					table.insert(floorData, cell:getData()) -- insert worker into workerData table (containing all workers on the floor)
			end
		end
		table.insert(floorsData, floorData)
	end
		saveData(floorsData)
	end



	self.tempMenu:update(dt)
	self.clock:update(dt)
end

function PlayState:render()
	for i, floor in pairs(self.floors) do
		floor:render()
	end
	self.tempMenu:render()
	self.clock:render()
	love.graphics.print("Money: $" .. (math.floor(money)), 100, 0)
end

function PlayState:saveFloor()
	local data = {}
	local floorsData = {}
		for i, floor in pairs(self.floors) do
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


