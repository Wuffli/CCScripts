local monitor = peripheral.find("monitor")
local rs = peripheral.find("rsBridge")


monitor.setBackgroundColor(colors.black)
monitor.setTextScale(0.5)


local systemCapacity = 0
local items = {}
local nItems = 0
local currentItems = 0
local newItems = 0




local systemCapacityOcc = nItems/systemCapacity * 100
local systemCapacityLeft = 100 - systemCapacityOcc

local width, height = monitor.getSize()




function calculate()
    systemCapacity = rs.getMaxItemDiskStorage() + rs.getMaxItemExternalStorage()
    items = rs.listItems()

    for _, item in pairs(items) do
        nItems = nItems + item.amount
    end

    newItems = nItems - currentItems
    currentItems = nItems

end

function draw()
    monitor.clear()

    local oldTerm = term.redirect(monitor)
    paintutils.drawFilledBox(2, 2, width-1, 4, colors.gray)
    paintutils.drawFilledBox(2, 2, systemCapacityOcc/(100/(width-2)), 4, colors.red)
    local oldTerm = term.redirect(oldTerm)

    monitor.setCursorPos(3, 3)
    monitor.write(math.floor(systemCapacityOcc * 100)/100 .. "%")
end

while True do
    calculate()
    draw()
end







 
