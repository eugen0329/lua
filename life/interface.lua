require "field"

Interface = {}

local numOfMenuFields = 3

function Interface:load(arg1, arg2, arg3, arg4, arg5)
    x1 = arg1
    y1 = arg2
    dt = { x = arg3, y = arg4 } 
    defaultColor = arg5

    menuField = { 
        {name = "Start", lighted = false, x = x1, y = y1},
        {name = "Exit", lighted = false, x = x1, y = y1+dt.y*3},
        {name = "Clear", lighted = false, x = x1, y = y1+dt.y}
    }
    --Flags
    command = nil
    gameStarted = nil
end

function Interface:draw(x,y)
    local i

    for i = 1, numOfMenuFields, 1 do
        if menuField[i].lighted then
            love.graphics.setColor(60,130,230)
            love.graphics.print(menuField[i].name, menuField[i].x, menuField[i].y)
            love.graphics.setColor(defaultColor.r,defaultColor.g, defaultColor.b)
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

    gameStarted = Interface:processSignal()
    command = nil
    return gameStarted
end

function Interface:processSignal()
    if command ~= nil then
        print(command)
    end
  
    if command == "Start" then
        if gameStarted then 
           return 0
        else
            return 1
        end
    else 
        if command == "Clear" then
            return love.load(defaultColor)
        else

            if command == "Exit" then
                love.event.push('quit')
            end
        end
    end
    if gameStarted then 
        return 1
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

