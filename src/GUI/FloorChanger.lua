-- controls the current floor and all floors

FloorChanger = Class{}

function FloorChanger:init()
	self.floors = {}
	local trash = math.random(math.floor(DEFAULT_FLOOR * (math.pow(1.5, #self.floors))), math.floor(DEFAULT_FLOOR * (math.pow(1.5, #self.floors)) * math.pow(1.1, #self.floors + 1)))
	self.buyMenu = UpgradeMenu ({x = VIRTUAL_WIDTH * .15 / 2 - 25, y = VIRTUAL_HEIGHT - 130, width = 50, height = 70, type = "Floor",
								cost = math.random(math.floor(DEFAULT_FLOOR * (math.pow(1.5, #self.floors))), math.floor(DEFAULT_FLOOR * (math.pow(1.5, #self.floors)) * math.pow(1.1, #self.floors + 1))), buttonText = "Buy", onClick = function() 
									if self.buyMenu:purchase() then
										self:makeNewFloor()
									end
									self.buyMenu.upgrading = true
									if currentFloor + 1 <= #self.floors then
										currentFloor = currentFloor + 1
									end
								end, timer = false}, floorNumber)
	self.buyMenu.upgrading = true
	currentFloor = 1

	self.upFloorBtn = Button({
		verticies =  {{VIRTUAL_WIDTH * .15 / 2, VIRTUAL_HEIGHT - 180}, {VIRTUAL_WIDTH * .15 / 2 - 25, VIRTUAL_HEIGHT - 130}, {VIRTUAL_WIDTH * .15 / 2 + 25, VIRTUAL_HEIGHT - 130}},
		onClick = function()
			if currentFloor + 1 <= #self.floors then
				currentFloor = currentFloor + 1
			end
		end
	}, "triangle")


	self.downFloorBtn = Button({
		verticies =  {{VIRTUAL_WIDTH * .15 / 2, VIRTUAL_HEIGHT - 10}, {VIRTUAL_WIDTH * .15 / 2 - 25, VIRTUAL_HEIGHT - 60}, {VIRTUAL_WIDTH * .15 / 2 + 25, VIRTUAL_HEIGHT - 60}},
		onClick = function()
			if currentFloor - 1 > 0 then
				currentFloor = currentFloor - 1
			end
		end
	}, "triangle")
	cubiclesOwned = 0
end

function FloorChanger:update(dt)
	if #self.floors > 0 then
		for i, floor in pairs(self.floors) do
			floor:update(dt)
		end
		if cubiclesOwned == 2 and achievementSystem.achievements["1st cubicle purchased"].unlocked == false then
			achievementSystem:addToQueue("1st cubicle purchased")
		end
		if cubiclesOwned == 50 and achievementSystem.achievements["50th cubicle"].unlocked == false then
			achievementSystem:addToQueue("50th cubicle")
		end
		if cubiclesOwned == 100 and achievementSystem.achievements["100th cubicle"].unlocked == false then
			achievementSystem:addToQueue("100th cubicle")
		end

	end

	self.buyMenu:update(dt)
	if self.buyMenu.button.clickable:isHovering() and money >= self.buyMenu.cost then
		self.buyMenu.button.buttonColor = "green"
	elseif self.buyMenu.button.clickable:isHovering() and money < self.buyMenu.cost then
		self.buyMenu.button.buttonColor = "red"
	else
		self.buyMenu.button.buttonColor = "gray"
	end

	-- our current calculations calculated this to be a nice scaled economy
	if math.floor(DEFAULT_FLOOR * (math.pow(1.5, #self.floors))) > self.buyMenu.cost then --when the actual price of a floor doesn't match what it should cost, make a new buy
		self.buyMenu.cost = math.random(math.floor(DEFAULT_FLOOR * (math.pow(1.5, #self.floors))), math.floor(DEFAULT_FLOOR * (math.pow(1.5, #self.floors)) * math.pow(1.1, #self.floors + 1)))
	end
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

function FloorChanger:makeNewFloor(cost)
	table.insert(self.floors, Floor(true, #self.floors + 1, nil))
end

function FloorChanger:loadSavedFloors(floors)
	self.floors = floors
end