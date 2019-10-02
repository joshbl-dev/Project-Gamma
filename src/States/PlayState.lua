PlayState = Class{__includes = BaseState}

function PlayState:init()
	self.floors = {Floor()}
	self.tempMenu = Button(0, 50, 120, 50, "Menu")
	self.clock = Clock(VIRTUAL_WIDTH / 2, 0)
end

function enter(data)
	self.floors = {}
	for i, floor in pairs(data) do
		table.insert(self.floors, Floor(floor))
	end
end

function PlayState:update(dt)

	local data = {}
	for i, floor in pairs(self.floors) do
		floor:update(dt)
		local floorData = {}
		for j, row in pairs(floor.grid.cells) do
			for i, cell in pairs(row) do
				if cell.cubicle.worker.bought then
					table.insert(floorData, true)
				else
					table.insert(floorData, false)
				end
			end
		end
		table.insert(data, floorData)
	end

	saveData(data)

	self.tempMenu:update(dt)
	self.clock:update(dt)
	if self.tempMenu.clickable.pressed then
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




