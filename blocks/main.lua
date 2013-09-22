require "field"
require "interface"
require "levelGenerator"
require "message"


function love.run()
    local f = love.graphics.newFont(20)
    love.graphics.setFont(f)

    love.graphics.setColor(60,130,230)
    love.graphics.setBackgroundColor(0, 0, 0, 255)

    levelNumber = 1
    endGame = false

    if love.load then love.load(levelNumber) end

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

        --if love.timer then love.timer.sleep(0.001) end
        if love.graphics then love.graphics.present() end
    end
end

function love.load(levelNumber)
    Interface:load(350,100,100,20, levelNumber)

    local levelName  = "level" .. levelNumber .. ".in"
    if love.filesystem.exists( levelName  ) then
        print(levelName )
        Field:load(Generate:field(levelName ))
    else
        endGame = true
    end

    if endGame then
        return Message:load() 
    end
    --Flags
    mouseClicked = false
    win = false
    button1 = nil

end

function love.update(dt)

    if endGame then
        return 0
    end

    win = Field:update(mouseClicked, button1)
    Interface:update(mouseClicked)

    if win then 
        return love.load(levelNumber  + 1)
    end
    
    mouseClicked = false
    button1 = nil
end

function love.draw()
    if endGame then
        return Message:draw() 
    end

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
    button1 = key
    if button1 then 
        endOfLine.selected = true
    end
    if key == 'escape' then 
        love.event.push('quit')
    end
end

