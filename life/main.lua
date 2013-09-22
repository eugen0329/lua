require "field"
require "interface"


function love.run()
    local f = love.graphics.newFont(20)
    love.graphics.setFont(f)

    local defaultColor = {r = 255, g = 255, b = 255}

    love.graphics.setColor(defaultColor.r,defaultColor.g, defaultColor.b)

    love.graphics.setBackgroundColor(0, 0, 0, 255)

    gameStarted = false


    if love.load then love.load(defaultColor) end

    local dt = 0

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c,d)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        -- Call update and draw
        if love.update then love.update(dt) end 
        if love.graphics then
            love.graphics.clear()
            if love.draw then love.draw() end
        end

        if love.timer then love.timer.sleep(0.1) end
        if love.graphics then love.graphics.present() end
    end
end

function love.load(arg1)
    local cell = { width = 15, heigth = 15, dist = 2}
    local defaultColor = arg1
    field = {size = {x = 20, y = 20 }}
    Interface:load(350,100,100,20, defaultColor)
    Field:load(cell.width, cell.heigth, cell.dist, field.size.x, field.size.y, defaultColor)

    --Flags
    mouseClicked = false
    win = false
end

function love.update(dt)

    
    gameStarted = Interface:update(mouseClicked)
    Field:update(mouseClicked, gameStarted)

    mouseClicked = false
end

function love.draw()
    Field:drawField()
    Interface:draw()
    --if win then 
        --love.graphics.print("well done!!", 260, 360)
    --end

end

-- Scan input signals
function love.mousepressed(x, y, button)
    if button == 'l' then
        mouseClicked = true
    else
        mouseClicked = false
    end
end

function love.keypressed( key, unicode )
    if key == 'escape' then 
        love.event.push('quit')
    end
end

