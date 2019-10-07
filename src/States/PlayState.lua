PlayState = Class{__includes = BaseState}

function PlayState:init()
	if newGame then
		self.floors = {Floor()}
	end
	self.tempMenu = Button(0, 50, 120, 50, "Menu")
	self.clock = Clock(VIRTUAL_WIDTH / 2, 0)
end

function PlayState:enter(saveData)
	if not newGame then
		self.floors = {}
		for i, floor in pairs(saveData) do
			print(floor[1])
			table.insert(self.floors, Floor(floor))
		end
	end
	self:saveFloor()
end

function PlayState:update(dt)

	for i, floor in pairs(self.floors) do
		floor:update(dt)
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
	if self.tempMenu.clickable.pressed then
		self:saveFloor()
		stateMachine:change("start")
	end
end

function PlayState:render()
	for i, floor in pairs(self.floors) do
		floor:render()
	end
	self.tempMenu:render()
	self.clock:render()
end

function PlayState:saveFloor()
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
		saveData(floorsData)
end


