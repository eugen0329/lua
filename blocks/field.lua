--require "levelGenerator"

Field = {}

function Field:load(arg1)
    cell = { width = 50, heigth = 50, dist = 5}
    field = arg1

    allignX = cell.width + cell.dist
    allignY = cell.width + cell.dist
    endOfLine = { x = 1, y = 1 , selected = false}

    -- Flags
    win = false
    button1 = Nil
    
end

function Field:drawField()
    local i, j

    for i = 1,  field.size.y, 1 do
        for j = 1, field.size.x,  1 do
            if field[i][j] == "green" then 
                love.graphics.setColor(0,250,0)
                Field:drawCell((j - 1) * allignX, (i - 1) * allignY, cell.width, cell.heigth)
                love.graphics.setColor(60,130,230)
            else 
                if field[i][j] == "yellow" then
                    love.graphics.setColor(255,255,0)
                    Field:drawCell((j - 1) * allignX, (i - 1) * allignY, cell.width, cell.heigth)
                    love.graphics.setColor(60,130,230)
                else
                    if field[i][j] == "red" then
                        love.graphics.setColor(250,0,0)
                        Field:drawCell((j - 1) * allignX, (i - 1) * allignY, cell.width, cell.heigth)
                        love.graphics.setColor(60,130,230)
                    else
                        Field:drawCell((j - 1) * allignX, (i - 1) * allignY, cell.width, cell.heigth)
                    end
                end
            end
        end
    end
end


function Field:update(mouseClicked)
    local i, j, x, y 

    x, y = love.mouse.getPosition()

    for i = 1,  field.size.x , 1 do
        for j = 1, field.size.y,  1 do
            Field:processMouseSignal(i, j, x, y, mouseClicked)
        end
    end
    
    Field:processKeyboardSignal(endOfLine.x, endOfLine.y)

    button1 = Nil

    if Field:checkField() == 0 then 
        win = true
    end
    return win
end 

-- Pocessing scanned signals
function Field:processMouseSignal(i, j, x, y , mouseClicked)
    if (j - 1) * allignX <= x and x < j * allignX and (i - 1) * allignY <= y and y < i * allignY then
         if mouseClicked and endOfLine.selected == false then
            if field[i][j] ~= "red" then
                if field[i][j] == "green" and endOfLine.x == j and endOfLine.y == i and endOfLine.selected == false then 
                    field[i][j] = "yellow"
                else
                    field[endOfLine.y][endOfLine.x] = "blue"
                    field[i][j] = "green"
                    endOfLine.x = j
                    endOfLine.y = i
                end
            end
        else
            if field[i][j] ~= "green" and field[i][j] ~= "red" then
                field[i][j] = "yellow"
            end
        end
    else
        if field[i][j] == "yellow" then
            field[i][j] = "blue"
        end
    end 
end

function Field:processKeyboardSignal(x, y)
    if button1 == 'up' then
        endOfLine.y = Field:paintVerticalCellLine(x, y, -1, 1)
    else 
        if button1 == 'down' then
            endOfLine.y = Field:paintVerticalCellLine(x, y, 1, field.size.y)
        else 
            if button1 == 'left' then
                endOfLine.x = Field:paintHorisontalCellLine(x, y, -1, 1)
            else
                if button1 == 'right' then
                    endOfLine.x =  Field:paintHorisontalCellLine(x, y, 1, field.size.x)
                end
            end
        end
    end
end

--Operations with field
function Field:paintVerticalCellLine(x, y, step, limit)
    local i, value
    value = y 
    for i = y + step, limit, step do
        print("paintVerticalCellLine1", i)
        if field[i][x] == "green" or field[i][x] == "red" then
            return i - step
        end
        field[i][x] = "green"
        value = i
    end
    print("paintVerticalCellLine2", value)
    return value 
end

function Field:paintHorisontalCellLine(x, y, step, limit)
    local j, value
    value = x 
    for j = x + step, limit, step do
        print("paintHorisontalCellLine1", j)
        if field[y][j] == "green" or field[y][j] == "red" then
            return j - step
        end
        field[y][j] = "green"
        value = j
    end
    print("paintHorisontalCellLine2", value)
    
    return value
end 

function Field:checkField()
    local i, j
    for i = 1,  field.size.y, 1 do
        for j = 1, field.size.x,  1 do
            if field[i][j] == "blue" or field[i][j] == "yellow" then
                return 1
            end
        end
    end
    return 0
end

function Field:drawCell( posX, posY, width, heigth )
    return love.graphics.rectangle("fill" ,posX, posY, width, heigth)
end







