function resetScreen(monitor)
    monitor.setBackgroundColor(colors.black)
    monitor.setCursorPos(1,1)
    monitor.setTextScale(1)
end
 
Button = { name = "Button" ,
        color = colors.gray,
        colorPressed = colors.lightGray,
        colorText = colors.White,
        isPressed = false }
 
 
function Button:new(object)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    return object
end 
 
ButtonDisplay = {monitor = nil, buttons = {} }
 
function ButtonDisplay:new(object)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    local eventHandler = coroutine.create(self.waitForButtonPress)
    coroutine.resume(eventHandler)
    return object
end
 
function ButtonDisplay:newButton(name, color, colorPressed, colorText)
    local Button = Button:new{}
    if name ~= nil then
        Button.name = name
    end
    table.insert(self.buttons, Button)
end

function ButtonDisplay:buttonsFromList(buttonsList)
    for index, button in ipairs(buttonsList) do
        self:newButton(button.name) --create Button
    end
end
 
function ButtonDisplay:render()
    monitor = self.monitor
    resetScreen(monitor)
    
    monitor.clear()
    
    
    for index, Button in ipairs(self.buttons) do
        startY = 2 + 4 * (index - 1)
        endY   = 4 * index
        startX = 2
        endX   = monitor.getSize() - 1
        
        --print(startY .. endY .. startX .. endX)
        
        
        
        local oldTerm = term.redirect(self.monitor)
        
        if Button.isPressed then
            paintutils.drawFilledBox(startX, startY, endX, endY, Button.colorPressed)
        else
            paintutils.drawFilledBox(startX, startY, endX, endY, Button.color)
        end
        
        term.redirect(oldTerm)
        
        monitor.setCursorPos(startX + 1, startY + 1)
        monitor.write(Button.name)
    end
end
 
function ButtonDisplay:waitForButtonPress()
    
    local index = -1
    local event, side, x, y = os.pullEvent("monitor_touch")
    if x > 1 and x < self.monitor.getSize() - 1 then
        index =  math.ceil(y / 4)
    end
    if index <= #self.buttons then
        self.buttons[index].isPressed = not self.buttons[index].isPressed
        --print(self.buttons[index].isPressed)
    else
        index = -1
    end

    return index
    
end