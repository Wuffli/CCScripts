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

local width, height = monitor.getSize()




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

    newItems = nItems - currentItems
    currentItems = nItems

end

function draw()
    monitor.setBackgroundColor(colors.black)
    monitor.clear()


    local oldTerm = term.redirect(monitor)
    paintutils.drawFilledBox(2, height -6, width-1, height -1, colors.gray)
    paintutils.drawFilledBox(5, height -5, systemCapacityOcc/(100/(width-4)), height -1, colors.red)
    paintutils.drawFilledBox(2, height -6, 2, height -1, colors.gray)
    paintutils.drawFilledBox(1, height -6, 1, height -1, colors.black)
    local oldTerm = term.redirect(oldTerm)
    monitor.setBackgroundColor(colors.black)

    monitor.setCursorPos(math.floor(width / 2) - 2, height -2)
    monitor.write(math.floor(systemCapacityOcc * 100)/100 .. "%")

    monitor.setCursorPos(15, 10)
    monitor.write(math.floor(newItems))
end

while true do
    calculate()
    draw()
end







 
