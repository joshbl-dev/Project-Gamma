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
	timeScale = 6.9*math.pow(10,-5)
	clock = Clock(VIRTUAL_WIDTH / 2, 0, true, 0)
	self.saveClock = Clock(-100, -100, false, 0)
	money = DEFAULT_GAME_MONEY
	moneyLost = 0
	self.lastSecond = -4
	allSalary = {}
	allSalary[0] = 0
	lastMonth = clock.month
end

function PlayState:enter(saveData)
	if not newGame then
		local floors = {}
		for i, floor in pairs(saveData[1]) do
			local cost = floor[1]
			table.insert(floors, Floor(false, i, floor))
		end
		self.floorChanger:loadSavedFloors(floors)
		self.floorChanger.buyMenu.cost = saveData[4]
		money = saveData[2]
		clock = Clock(VIRTUAL_WIDTH / 2, 0, true, saveData[3])
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

	if love.keyboard.wasPressed("]") then
		timeScale = 6.9*math.pow(10,-7)
	elseif love.keyboard.wasReleased("]") and timeScale ~= 6.9*math.pow(10,-5) then
		timeScale = 6.9*math.pow(10,-5)
	end
	lastMonth = clock.month
	clock:update(dt)
	self.floorChanger:update(dt)
	self.tempMenu:update(dt)
	if allSalary[1] ~= nil then
		for i=1, #allSalary do
			moneyLost = moneyLost + allSalary[i]
		end
		clear(allSalary)
		allSalary[1] = nil
	end
	if moneyLost ~= 0 then
		print(moneyLost)
		money = money - moneyLost
		self.textMoneyLost = moneyLost
		self.showLostMoneyClock = Clock(-9999, -9999, false, 0)
		moneyLost = 0
	end
	if self.showLostMoneyClock then
		self.showLostMoneyClock:update(dt)
		print(self.showLostMoneyClock.seconds)
	end
	
end

function PlayState:render()
	self.floorChanger:render()
	clock:render()
	self.tempMenu:render()
	setColor(colors["black"])
	love.graphics.print("Money: $" .. (math.floor(money)), 100, 0)
	if self.showLostMoneyClock and self.showLostMoneyClock.seconds < 3 then
		--print(self.saveClock.seconds - self.lastSecond)
		setColor(colors["red"])
		love.graphics.print("-$" .. math.floor(self.textMoneyLost), 170, 20)
	elseif self.showLostMoneyClock then
		self.showLostMoneyClock = nil
	end
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
	table.insert(data, clock.time)
	table.insert(data, self.floorChanger.buyMenu.cost)
	saveData(data)
end