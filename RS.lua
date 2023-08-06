local monitor = peripheral.find("monitor")
local rs = peripheral.find("rsBridge")


monitor.setBackgroundColor(colors.black)
monitor.setTextScale(0.5)


local systemCapacity = 0
local items = {}
local nItems = 0
local currentItems = 0
local newItems = 0
local systemCapacityOcc = 0
local systemCapacityLeft = 0
local oldTime = 0
local itemsPerSecond = 0
local biggetItemsPerSecond = 0

local width, height = monitor.getSize()

local graphSizeX, graphSizeY = width - 5, 20
local graphEntries = {}

for i = 1, graphSizeX do
    table.insert(graphEntries, 0)
end

function updateGraph()
    local current_time = os.time()
    timeDiff = os.time() - oldTime
    if os.time() - oldTime < 0 then
        timeDiff = timeDiff + 24
    end
    timeDiff = timeDiff * 50
    if timeDiff > 120
    
        newItems = newItems + nItems - currentItems
        itemsPerSecond = newItems/timeDiff
        
        if itemsPerSecond > biggetItemsPerSecond then
            biggetItemsPerSecond = itemsPerSecond
        end

        oldTime = os.time()

    end
    
end



function calculate()

    systemCapacity = 0
    items = {}
    nItems = 0
    systemCapacityOcc = 0
    systemCapacityLeft = 0

    systemCapacity = rs.getMaxItemDiskStorage() + rs.getMaxItemExternalStorage()
    items = rs.listItems()

    for _, item in pairs(items) do
        nItems = nItems + item.amount
    end

    systemCapacityOcc = nItems/systemCapacity * 100
    systemCapacityLeft = 100 - systemCapacityOcc

    
    currentItems = nItems
    

end

function draw()
    monitor.setBackgroundColor(colors.black)
    monitor.clear()


    local oldTerm = term.redirect(monitor)
    paintutils.drawFilledBox(2, height -6, width-1, height -1, colors.gray)
    paintutils.drawFilledBox(5, height -5, math.ceil(systemCapacityOcc/100 * width-4), height -2, colors.red)
    paintutils.drawFilledBox(2, height -6, 2, height -1, colors.gray)
    paintutils.drawFilledBox(1, height -6, 1, height -1, colors.black)
    local oldTerm = term.redirect(oldTerm)

    monitor.setCursorPos(math.floor(width / 2) - 2, height -3)
    local prozent = math.floor(100*systemCapacityOcc)/100 .. "%"
    for i = 1, #prozent do
        local char = prozent:sub(i, i)
        local bg = monitor.getBackgroundColor()
        monitor.setBackgroundColor(bg)
        monitor.write(char)
    end

    monitor.setCursorPos(15, 10)
    monitor.write(math.floor(newItems))
    monitor.setCursorPos(15, 11)
    monitor.write(math.floor(itemsPerSecond))
    monitor.setCursorPos(15, 12)
    monitor.write(math.floor(biggetItemsPerSecond))
end
calculate()
biggetItemsPerSecond = 0

while true do
    calculate()
    updateGraph()
    draw()
end







 
