Popup = Class{}

function Popup:init(text)
	self.text = text
	self.width = 400
	self.height = 300
	self.pushed = false
	self.okay = Button ({ x = VIRTUAL_WIDTH / 2 - 120/2,
			y = VIRTUAL_HEIGHT / 2 - 50/2 + self.height/3,
			width = 120,
			height = 50,
			text = "Okay", onClick = function()
				self.pushed = true;
			end}, "rect")
end

function Popup:update(dt)
	self.okay:update(dt)
end

function Popup:render()
	setColor(colors['white'])
	love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - self.width/2, VIRTUAL_HEIGHT/2 - self.height/2, self.width, self.height)
	setColor(colors["black"])
	love.graphics.print(self.text, VIRTUAL_WIDTH/2 - self.width/2 + 20, VIRTUAL_HEIGHT/2 - self.height/2 + 10)
	self.okay:render()
end