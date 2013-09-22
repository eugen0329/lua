require "field"

Interface = {}

local numOfMenuFields = 3

function Interface:load(arg1, arg2, arg3, arg4, arg5)
    x1 = arg1
    y1 = arg2
    dt = { x = arg3, y = arg4 } 
    levelNumber = arg5

    menuField = { 
        {name = "New game", lighted = false, x = x1, y = y1},
        {name = "Exit", lighted = false, x = x1, y = y1+dt.y*3},
        {name = "Next level", lighted = false, x = x1, y = y1+dt.y}
    }
    --Flags
    command = nil
end

function Interface:draw(x,y)
    local i

    for i = 1, numOfMenuFields, 1 do
        if menuField[i].lighted then
            love.graphics.setColor(0,250,0)
            love.graphics.print(menuField[i].name, menuField[i].x, menuField[i].y)
            love.graphics.setColor(60,130,230)
        else
            love.graphics.print(menuField[i].name,menuField[i].x, menuField[i].y)
        end
    end   
end

function Interface:update(mouseClicked)
    local i, x, y
    x, y = love.mouse.getPosition()

    for i = 1, numOfMenuFields, 1 do
        Interface:processMouseSignal(i, x, y, mouseClicked)
    end

    Interface:processSignal()
    command = nil
end

function Interface:processSignal()
    if command ~= nil then
        print(command)
    end
  
    if command == "New game" then 
        return love.load(levelNumber)
    else 
        if command == "Next level" then
            return love.load(levelNumber + 1)
        else

            if command == "Exit" then
                love.event.push('quit')
            end
        end
    end
end

function Interface:processMouseSignal(i, x, y, mouseClicked)
    if menuField[i].x < x and x < menuField[i].x + dt.x and menuField[i].y < y and y < menuField[i].y + dt.y then
        if menuField[i].lighted == false then
            menuField[i].lighted = true
        end
        if mouseClicked then
            command = menuField[i].name
        end
    else
        menuField[i].lighted = false
    end
end

