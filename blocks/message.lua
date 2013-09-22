Message = {}

function Message:load()
	width = love.graphics.getWidth( )
	height = love.graphics.getHeight()
end

function Message:draw()
	love.graphics.print("Congratulations!!!You are passed the game", width/2-220, height/2)
	love.graphics.print("Press Esc to exit", width/2-100, height/2+20)
	--print("Message:draw")
end

