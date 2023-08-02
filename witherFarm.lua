import using local buttons = require("buttons")
 
local Buttons = require("buttons")
local monitor = peripheral.find("monitor")

local buttonDisplay = ButtonDisplay:new()
buttonDisplay.monitor = monitor

local buttonsList = {
    { name = "Global Button", globalButton = true },
    { name = "Wither Builder", outputDirection = "right", offState = false },
    { name = "Mob Grinders", outputDirection = "left", offState = false  },
    { name = "Fans", outputDirection = "down", offState = false  }
    }

buttonDisplay:buttonsFromList(buttonsList)
buttonDisplay:render()
setAll(false)


function switchOutput(direction)
    local currentOutput = not redstone.getOutput(direction)
    redstone.setOutput( direction, currentOutput )
end

function xor(a, b)
    return (a or b) and not (a and b)
end

function setAll(state)
    for index, button in ipairs(buttonsList)
        if button.outputDirection ~= nil then

            output = xor(state, button.offState)
            redstone.setOutput( button.outputDirection, output )

        end
    end
end

function globalButton()
    setAll(buttonDisplay.buttons[1].isPressed)
end

function checkIfAllAreOffOrOn()
    b = buttonDisplay.buttons
    if not ( b[2].isPressed and b[3].isPressed and b[4].isPressed ) then 
        b[1].isPressed = false
    end
    if ( b[2].isPressed and b[3].isPressed and b[4].isPressed ) then 
        b[1].isPressed = true
    end
end

function buttonPressed(button)
    if button.globalButton then
        globalButton()
    end

    elseif button.outputDirection ~= nil then
        switchOutput(button.outputDirection)
    end

    checkIfAllAreOffOrOn()

end
 

 
while true do
    local index = buttonDisplay:waitForButtonPress()
    buttonPressed(buttons[index])
    
    buttonDisplay:render()
end
 
 