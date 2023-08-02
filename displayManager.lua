local VirtualDisplay = {monitor = nil}

-- local window = { 
--     size = { x = 0, y = 0},
--     position = { topleftX = 0, topleftY = 0 }
-- }


function VirtualDisplay:new(monitor)
    object = {}
    setmetatable(object, self)
    self.__index = self

    self.monitor = monitor

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

local monitor = peripheral.find("monitor")

local display = VirtualDisplay:new(monitor)
display.monitor = monitor

display.write("Hi!")