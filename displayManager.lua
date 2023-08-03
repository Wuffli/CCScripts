local VirtualDisplay = {monitor = nil}

function VirtualDisplay:new(monitor)
    local object = {monitor = monitor}
    setmetatable(object, self)
    self.__index = self
    return object
end

function VirtualDisplay:setTextScale(scale)
    self.monitor.setTextScale(scale)
end

function VirtualDisplay:getTextScale()
    return self.monitor.getTextScale()
end

function VirtualDisplay:write(text)
    self.monitor.write(text)
end

function VirtualDisplay:scroll(y)
    self.monitor.scroll(y)
end

function VirtualDisplay:getCursorPos()
    return self.monitor.getCursorPos()
end

function VirtualDisplay:setCursorPos(x, y)
    self.monitor.setCursorPos(x, y)
end

function VirtualDisplay:getCursorBlink()
    return self.monitor.getCursorBlink()
end

function VirtualDisplay:setCursorBlink(blink)
    self.monitor.setCursorBlink(blink)
end

function VirtualDisplay:getSize()
    return self.monitor.getSize()
end

function VirtualDisplay:clear()
    self.monitor.clear()
end

function VirtualDisplay:clearLine()
    self.monitor.clearLine()
end

function VirtualDisplay:getTextColour()
    return self.monitor.getTextColour()
end

function VirtualDisplay:getTextColor()
    return self.monitor.getTextColor()
end

function VirtualDisplay:setTextColour(colour)
    self.monitor.setTextColour(colour)
end

function VirtualDisplay:setTextColor(colour)	
    self.monitor.setTextColor(colour)	
end

function VirtualDisplay:getBackgroundColour()
    return self.monitor.getBackgroundColour()
end

function VirtualDisplay:getBackgroundColor()
    return self.monitor.getBackgroundColor()
end

function VirtualDisplay:setBackgroundColour(colour)
    self.monitor.setBackgroundColour(colour)
end

function VirtualDisplay:setBackgroundColor(colour)
    self.monitor.setBackgroundColor(colour)
end

function VirtualDisplay:isColour()
    return self.monitor.isColour()
end

function VirtualDisplay:isColor()
    return self.monitor.isColor()
end

function VirtualDisplay:blit(text, textColour, backgroundColour)
    self.monitor.blit(text, textColour, backgroundColour)
end

function VirtualDisplay:setPaletteColour(index, hexColour)
    self.monitor.setPaletteColour(index, hexColour)
end

function VirtualDisplay:setPaletteColor(index, hexColor)
    self.monitor.setPaletteColor(index, hexColor)
end

function VirtualDisplay:getPaletteColour(colour)
    return self.monitor.getPaletteColour(colour)
end

function VirtualDisplay:getPaletteColor(colour)	
    return self.monitor.getPaletteColor(colour)	
end

local Window = { 
    display = nil,
    size = { x = 1, y = 1},
    position = { x = 1, y = 1 }, --marks the position of the top left corner of the window
    cursorPosition = { x = 1, y = 1 }
}

function Window:new()
    local object = {}
    setmetatable(object, self)
    self.__index = self
    return object
end

function VirtualDisplay:newWindow(sizeX, sizeY, posX, posY)
    local window = Window:new()
    window.display = self

    window.size.x = sizeX or 5
    window.size.y = sizeY or 5
    window.position.x = posX or 1
    window.position.y = posY or 1

    return window
end

function Window:getSize()
    return self.size[1], self.size[2]
end

function Window:setSize(x, y)
    self.size.x = x
    self.size.y = y
end

function Window:getPosition()
    return self.position.x, self.position.y
end

function Window:setPosition(x, y)
    self.position.x = x
    self.position.y = y
end

function Window:monitorToWindowPosition(x, y)
    local monitorPositionX, monitorPositionY = self.display:getCursorPos()
    local windowPositionX, windowPositionY = monitorPositionX - self.position.x + 1, monitorPositionY - self.position.y + 1
    return windowPositionX, windowPositionY
end

function Window:windowToMonitorPosition(x, y)
    local monitorPositionX, monitorPositionY = x + self.position.x - 1, y + self.position.y - 1
    return monitorPositionX, monitorPositionY
end

function Window:getCursorPosition()
    --local monitorPositionX, monitorPositionY = self.display:getCursorPos()
    --local cursorPositionX, cursorPositionY = monitorPositionX - self.position.x + 1, monitorPositionY - self.position.y + 1
    return self.cursorPosition.x, self.cursorPosition.y
end


function Window:setCursorPosition(x, y)
    if x <= self.size.x and y <= self.size.y then
        --local cursorPositionX, cursorPositionY = x + self.position.x - 1, y + self.position.y - 1
        --self.display:setCursorPos(cursorPositionX, cursorPositionY)
        self.cursorPosition.x = x
        self.cursorPosition.y = y
        return 0
    else
        return -1
    end
end

function Window:write(text)
    local monitorX, monitorY = self:windowToMonitorPosition(self.cursorPosition.x, self.cursorPosition.y)
    print(monitorX .. monitorY)
    self.display:setCursorPos( monitorX, monitorY )
    local result
    local debug = ""
    for i = 1, #text do
        local char = text:sub(i, i)
        
        if self.cursorPosition.x <= self.size.x then
            self.display:write(char)
            self.cursorPosition.x = self.cursorPosition.x + 1
            debug = debug .. "i"
        else
            result = self:setCursorPosition(1, self.cursorPosition.y + 1)
            debug = debug .. "b"
        end
        if result == -1 then
            print("brokey")
            break
        else
            self.cursorPosition.y = self.cursorPosition.y + 1
        end
    end
    print(debug)
end

monitor = peripheral.find("monitor")

local display = VirtualDisplay:new(monitor)
display:clear()
display:setTextScale(0.5)
local firstWindow = display:newWindow(10, 10, 25, 25)
firstWindow:write("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")

