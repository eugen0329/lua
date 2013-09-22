Generate = {}

function Generate:field(levelName)
	local i, j, condition
	
	condition = Generate:readCondition(levelName)

	local field = {size = { x = #condition[1], y = #condition} }
	print(field.size.x, field.size.y)
	for i = 1, field.size.y, 1 do
		field[i] = {}
		for j = 1, field.size.x, 1 do
			if condition[i][j] == 1 then 
				field[i][j] = "red"
			else
				field[i][j] = "blue"
			end
		end
	end
	--print("Generate:field",field.size.x,field.size.y, field[1][3])
	return field
end


function Generate:readCondition(levelName)

	local i, j, buffer_str
    local levelData, condition = {}, {}

    for buffer_str in love.filesystem.lines (levelName) do
       table.insert (levelData, buffer_str)
    end

    for i = 1, #levelData , 1 do
        condition[i] = {}
        for j = 1, #levelData[i], 1 do
           condition[i][j] = string.byte (levelData[i],j) - 48 
           --print(condition[i][j])
        end
    end
		
	return condition
end