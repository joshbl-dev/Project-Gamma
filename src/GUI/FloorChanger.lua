FloorChanger = Class{}

function FloorChanger:init()
	self.floors = {}

	self.buyMenu = UpgradeMenu ({x = 10, y = VIRTUAL_HEIGHT - 130, width = 50, height = 70, type = "Floor",
								cost = DEFAULT_FLOOR * (math.pow(1.5, #self.floors)), buttonText = "Buy", onClick = function() 
									self.buyMenu:purchase()
									self:makeNewFloor()
									self.buyMenu.upgrading = true
								end, timer = false}, floorNumber)
	self.buyMenu.upgrading = true
	currentFloor = 1

	self.upFloorBtn = Button({
		verticies =  {{35, VIRTUAL_HEIGHT - 180}, {10, VIRTUAL_HEIGHT - 130}, {60, VIRTUAL_HEIGHT - 130}},
		onClick = function()
			if currentFloor + 1 <= #self.floors then
				currentFloor = currentFloor + 1
			end
		end
	}, "triangle")


	self.downFloorBtn = Button({
		verticies =  {{35, VIRTUAL_HEIGHT - 10}, {10, VIRTUAL_HEIGHT - 60}, {60, VIRTUAL_HEIGHT - 60}},
		onClick = function()
			if currentFloor - 1 > 0 then
				currentFloor = currentFloor - 1
			end
		end
	}, "triangle")
end

function FloorChanger:update(dt)
	if #self.floors > 0 then
		for i, floor in pairs(self.floors) do
			floor:update(dt)
		end
	end
	
	if DEFAULT_FLOOR * (math.pow(1.5, #self.floors)) ~= self.buyMenu.cost then --when the actual price of a floor doesn't match what it should cost, make a new buy
		self.buyMenu.cost = DEFAULT_FLOOR * (math.pow(1.5, #self.floors))
		self.buyMenu:render()
	end
	self.buyMenu:update(dt)
	self.upFloorBtn:update(dt)
	self.downFloorBtn:update(dt)
end

function FloorChanger:render()
	if #self.floors > 0 then
		self.floors[currentFloor]:render()
	end
	self.buyMenu:render()
	self.upFloorBtn:render()
	self.downFloorBtn:render()
end

function FloorChanger:makeNewFloor()
	table.insert(self.floors, Floor(true, #self.floors + 1))
end

function FloorChanger:loadSavedFloors(floors)
	self.floors = floors
end