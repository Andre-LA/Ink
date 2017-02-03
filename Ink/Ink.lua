--require "lclass/class"
utf8 = require "utf8"
--class "Ink"

  --------------------------------------
----------------------------------------
--                                  ----
--   █████████████  █     █         ----
--     ██           ██  ██          ----
--     ██ ████    █ ████      █     ----
--     ██ ██ ██  ██ ██ ███   ██ █   ----
--     ██ ██  ██ ██ ██  ████ ████   ----
--     ██ ██   ███  ██    ███████   ----
--   █████████████   █     ████     ----
--                                  ----
--------------------------------------
-- Ink by Andre-LA

local Ink = {}

function Ink:Ink ()
    local nw = {}

    self.instances = {}
    self.groups = {}
    self.instancesOrder = {}
    self.font = love.graphics.newFont( "Ink/fonts/FreeSans.ttf", 18)
    self.onHover = false

    self:newInstance("Ink_origin", "Ink_empty", {position = {0, 0}, size = {0, 0}, value = "Ink ^^"})

    setmetatable(nw, {__index = self})
    return nw
end

function Ink:newInstance (instance_name, module_name, initial_values)
    -- Load module
    self.instances[instance_name] = assert(love.filesystem.load("Ink/modules/" .. module_name .. ".lua"))()

    -- Start module
    self.instances[instance_name]:start(initial_values, self, instance_name)

    -- Set the name of the module and the birth position will be the parent position
    self.instances[instance_name].name = instance_name
    self.instances[instance_name].pos.x = self.instances[self.instances[instance_name].parent].pos.x
    self.instances[instance_name].pos.y = self.instances[self.instances[instance_name].parent].pos.y

    -- The parentPos will use the memory of the parent position
    self.instances[instance_name].parentPos = self.instances[self.instances[instance_name].parent].pos

    -- Register this module in instancesOrder table
    table.insert(self.instancesOrder, instance_name)

    -- Return the instance
    return self.instances[instance_name]
end

function Ink:newGroup (groupName, instances)
    -- Create table
    self.groups[groupName] = {}

    -- Link the instances in this group if possible
    if instances ~= nil then
        for i=1, #instances do
            table.insert(self.groups[groupName], instances[i])
        end
    end

    -- return group
    return self.groups[groupName]
end

function Ink:insertOnGroup (groupName, instances)
    -- Link the instances in this group
    for i=1, #instances do
        table.insert(self.groups[groupName], instances[i])
    end
end

function Ink:deleteAllInstances ()
    self.instances = {}
    self.instancesOrder = {}
    self:newInstance("Ink_origin", "Ink_empty", {position = {0, 0}, size = {0, 0}, value = "Ink ^^"})
    self.onHover = false
end

-- Love callbacks>>
function Ink:update (dt)
    local aInstanceHaveHover = false
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self:updateparent(self.instances[instanceName], dt)
            self:detectvisibility(self.instances[instanceName])

            if self.instances[instanceName].isVisible then
                if self.instances[instanceName].inHover == true then
                    self.instances[instanceName]:hover()
                    aInstanceHaveHover = true
                end

                self:hover(self.instances[instanceName])
                self.instances[instanceName]:update(dt)
                if love.mouse.isDown(1) then
                    self.instances[instanceName]:mousedown(love.mouse.getX(), love.mouse.getY(), 1)
                end
            end
        end
    end
    if not aInstanceHaveHover then self.onHover = false end
end

function Ink:draw ()
    -- reset coordinate system
    love.graphics.push()
    love.graphics.origin()

    -- backup font and use the font used in ink
    local previousFont = love.graphics.getFont()
    love.graphics.setFont(self.font)

    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            if self.instances[instanceName].isVisible then
                self.instances[instanceName]:draw()
            end
        end
    end

    -- reset coordinate system
    love.graphics.pop()

    -- reset the font
    love.graphics.setFont(previousFont)
end

function Ink:textinput (text)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:textinput(text)
        end
    end
end

function Ink:keypressed (key, scancode, isrepeat)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:keypressed(key, scancode, isrepeat)
        end
    end
end

function Ink:keyreleased (key)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:keyreleased(key)
        end
    end
end

function Ink:directorydropped ()
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:directorydropped ()
        end
    end
end
function Ink:filedropped (file)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:filedropped (file)
        end
    end
end
function Ink:focus (focus)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:focus (focus)
        end
    end
end
function Ink:lowmemory ()
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:lowmemory ()
        end
    end
end
function Ink:mousefocus (focus)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:mousefocus (focus)
        end
    end
end
function Ink:mousemoved (x, y, dx, dy, istouch)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:mousemoved (x, y, dx, dy, istouch)
        end
    end
end
function Ink:mousepressed (x, y, button, istouch)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:mousepressed (x, y, button, istouch, instanceName)
        end
    end
end
function Ink:mousereleased (x, y, button, istouch)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:mousereleased (x, y, button, istouch)
        end
    end
end
function Ink:quit()
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:quit()
        end
    end
end
function Ink:touchmoved (id, x, y, dx, dy, pressure)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:touchmoved (id, x, y, dx, dy, pressure)
        end
    end
end
function Ink:touchpressed (id, x, y, dx, dy, pressure)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:touchpressed (id, x, y, dx, dy, pressure)
        end
    end
end
function Ink:touchreleased (id, x, y, dx, dy, pressure)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:touchreleased (id, x, y, dx, dy, pressure)
        end
    end
end
function Ink:visible(visible)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:visible(visible)
        end
    end
end
function Ink:wheelmoved (x, y)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:wheelmoved (x, y)
        end
    end
end
function Ink:resize(w, h)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:resize(w, h)
        end
    end
end
function Ink:textedited (text, start, length)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:textedited (text, start, length)
        end
    end
end
function Ink:gamepadaxis (joystick, axis, value)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:gamepadaxis (joystick, axis, value)
        end
    end
end
function Ink:gamepadpressed (joystick, button)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:gamepadpressed (joystick, button)
        end
    end
end
function Ink:gamepadreleased (joystick, button)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:gamepadreleased (joystick, button)
        end
    end
end
function Ink:joystickadded (joystick)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:joystickadded (joystick)
        end
    end
end
function Ink:joystickaxis (joystick, axis, value)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:joystickaxis (joystick, axis, value)
        end
    end
end
function Ink:joystickhat (joystick, hat, direction)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:joystickhat (joystick, hat, direction)
        end
    end
end
function Ink:joystickpressed (joystick, button)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:joystickpressed (joystick, button)
        end
    end
end
function Ink:joystickreleased (joystick, button)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:joystickreleased (joystick, button)
        end
    end
end
function Ink:joystickremoved (joystick)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:joystickremoved (joystick)
        end
    end
end

--<<Love callbacks

-- Ink functions>>

function Ink:updateparent (v, dt)
    v.size.x = v.sizeInterpolDisabled ~= true and self:basicInterpolation(v.size.x, v.localSize.x, 3 * dt) or v.localSize.x
    v.size.y = v.sizeInterpolDisabled ~= true and self:basicInterpolation(v.size.y, v.localSize.y, 3 * dt) or v.localSize.y

    v.pos.x = v.posInterpolDisabled ~= true and self:basicInterpolation(v.pos.x, v.localPos.x - (v.size.x * v.pivot.x) + v.parentPos.x, 3 * dt) or v.localPos.x + (v.size.x * v.pivot.x) + v.parentPos.x
    v.pos.y = v.posInterpolDisabled ~= true and self:basicInterpolation(v.pos.y, v.localPos.y - (v.size.y * v.pivot.y) + v.parentPos.y, 3 * dt) or v.localPos.y + (v.size.y * v.pivot.y) + v.parentPos.y
end

function Ink:basicInterpolation (initial, final, interpolation)
    --return (initial + final) * interpolation
    return initial + ((final - initial) * interpolation)
end

function Ink:detectvisibility (v)
    local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}
    v.isVisible = v.pos.x <= love.graphics.getWidth() and v.pos.y <= love.graphics.getHeight()
end

function Ink:hover (v)
    local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}

    -- verify if the mouse is over the geometry of the instance
    local inHover = self:detectHover(v.geometry, v.pos, v.size)

    if inHover then
        -- execute the Hover function of the module
        if not self.onHover then
            v:hover()
            v.inHover = true
            self.onHover = true
        end
    else
        v.inHover = false
        v:nothover()
    end
end

-- <<Ink functions

-- Ink functions to help you ;)>>
function Ink:detectHover (type, pos, size)
    local mousePosx, mousePosy = love.mouse.getPosition()
    local ret = false;

    if type == "rectangle" then
        if (mousePosx > pos.x and mousePosx < pos.x + size.x) and
        (mousePosy > pos.y and mousePosy < pos.y + size.y) then
            ret = true
        end
    elseif type == "circle" then
        if math.sqrt(math.pow(math.abs(mousePosx - pos.x), 2)
        + math.pow(math.abs(mousePosy - pos.y), 2)) <= size.x then
            ret = true
        end
    end

    return ret
end
-- <<Ink functions to help you ;)

return Ink:Ink()
