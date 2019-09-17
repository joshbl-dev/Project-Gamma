StartState = Class{__includes = BaseState}

function StartState:init()
end

function StartState:update(dt)
	stateMachine:change("play")
end

function StartState:render()
end




