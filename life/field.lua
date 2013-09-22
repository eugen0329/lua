--require "levelGenerator"

Field = {}

function Field:load(arg1, arg2, arg3, arg4, arg5)
    local i, j
    cell = { width = arg1, heigth = arg2, dist = arg3}
    field = {
        present = {},
        next = {},
        size = {x = arg4, y = arg5}
    }
    
    for i = 1, field.size.y, 1 do
        field.present[i] = {}
        field.next[i] = {}
        for j = 1, field.size.x, 1 do
            field.present[i][j] = {v = 0, {lighted = false}}
            field.next[i][j] = 0
                        --print(field.present[i][j])
        end
    end

    allign = { x = cell.width + cell.dist, y = cell.width + cell.dist }
    allign.y = cell.width + cell.dist


    -- Flags
    win = false
    button1 = Nil
    
end

function Field:drawField()
    local i, j

    for i = 1,  field.size.y, 1 do
        for j = 1, field.size.x,  1 do
            if field.present[i][j].v == 0 then 
               
                if field.present[i][j].lighted then
                    love.graphics.setColor(192,192,192)
                    Field:drawCell((j - 1) * allign.x, (i - 1) * allign.y, cell.width, cell.heigth)
                    love.graphics.setColor(255,255,255)
                else
                     Field:drawCell((j - 1) * allign.x, (i - 1) * allign.y, cell.width, cell.heigth) 
                end
            else
                if field.present[i][j].v == 1 then
                    love.graphics.setColor(60,130,230)
                    Field:drawCell((j - 1) * allign.x, (i - 1) * allign.y, cell.width, cell.heigth)
                    love.graphics.setColor(255,255,255)
                end

            end
        end
    end
end


function Field:update(mouseClicked, gameStarted)
    local i, j, x, y 

    if gameStarted then
        print("chanege gen call")
        return Field:changeGenertion()
    end

    x, y = love.mouse.getPosition()

    for i = 1,  field.size.x , 1 do
        for j = 1, field.size.y,  1 do
            Field:processMouseSignal(i, j, x, y, mouseClicked)
        end
    end
end 

-- Pocessing scanned signals
function Field:processMouseSignal(i, j, x, y , mouseClicked)
    if (j - 1) * allign.x <= x and x < j * allign.x and (i - 1) * allign.y <= y and y < i * allign.y then
        if mouseClicked then
            if field.present[i][j].v == 1 then 
                field.present[i][j].v = 0
                field.present[i][j].lighted = true
            else
                field.present[i][j].v = 1

            end
        else
            if field.present[i][j].v == 0 then
               field.present[i][j].lighted = true
            end
        end
    else
        if field.present[i][j].lighted == true then
            field.present[i][j].lighted = false
        end
    end 
end

function Field:drawCell( posX, posY, width, heigth )
    return love.graphics.rectangle("fill" ,posX, posY, width, heigth)
end

function Field:changeGenertion()
    local i, j
    for i = 1, field.size.y, 1 do
        for j = 1, field.size.x, 1 do
            field.next[i][j] = Field:checkCell( i, j)
        end
    end

    Field:copyGenerations()
end

function Field:checkCell(i, j)
    local left, right, top, bottom, amount
    print(field.size.y, field.size.y)

    if i == 1 then
        top = field.size.y
        bottom = i + 1 
    else
        if i == field.size.y then
            top = i - 1
            bottom = 1
        else
            top = i - 1
            bottom = i+1 
        end
    end

    if j == 1 then 
        left = field.size.x 
        right = j + 1 
    else
        if j == field.size.x then
            left = j - 1
            right = 1
            print("--")
        else 
            left = j - 1
            right = j + 1 
        end
    end 
    print(i, left, right, top, bottom)
    amount = field.present[top][left].v + field.present[top][j].v + field.present[top][right].v + 
             field.present[i][left].v + field.present[i][right].v + 
             field.present[bottom][left].v + field.present[bottom][j].v + field.present[bottom][right].v

    if field.present[i][j].v == 1 then 
        if amount == 2 or amount == 3 then 
            return 1
        else 
            return 0
        end
    else
        if amount == 3 then
            return 1
        else
            return 0
        end
    end
end
function Field:copyGenerations()
    local i, j
    for i = 1, field.size.y, 1 do
        for j = 1, field.size.x, 1 do
            field.present[i][j].v = field.next[i][j]
        end
    end
end





