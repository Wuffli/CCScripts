import using local buttons = require("buttons")
example:
 
local Buttons = require("Buttons")
local monitor = peripheral.find("monitor")
 
redstone.setOutput("back", true)
redstone.setOutput("right", false)
redstone.setOutput("left", false)
 
function Light()
    redstone.setOutput("back", not redstone.getOutput("back"))
end
 
function Grinder()
    redstone.setOutput("left", not redstone.getOutput("left"))
end
 
function Fans()
    redstone.setOutput("right", not redstone.getOutput("right"))
end
 
 
 
local buttons = {
                { name = "Light", func = Light },
                { name = "Grinder", func = Grinder },
                { name = "Fans", func = Fans }
                }
 
buttonDisplay = ButtonDisplay:new()
 
for index, button in ipairs(buttons) do
    buttonDisplay:newButton(button.name)
end
 
buttonDisplay.monitor = monitor
buttonDisplay:render()
 
while true do
    local index = buttonDisplay:waitForButtonPress()
    buttons[index].func()
    
    buttonDisplay:render()
end
 
 