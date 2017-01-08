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
    self.font = love.graphics.newFont("Ink/fonts/FreeSans.ttf", 18)
    self.onHover = false

    self:New_Instance("Ink_origin", "Ink_empty", {position = {0, 0}, size = {0, 0}, value = "Ink ^^"})

    setmetatable(nw, {__index = self})
    return nw
end

function Ink:New_Instance (instance_name, module_name, initial_values)
    -- Load module
    self.instances[instance_name] = assert(love.filesystem.load("Ink/modules/" .. module_name .. ".lua"))()

    -- Start module
    self.instances[instance_name]:Start(initial_values, self, instance_name)

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

function Ink:New_Group (groupName, instances)
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

function Ink:Insert_On_Group (groupName, instances)
    -- Link the instances in this group
    for i=1, #instances do
        table.insert(self.groups[groupName], instances[i])
    end
end

function Ink:Delete_All_Instances ()
    self.instances = {}
    self.instancesOrder = {}
    self:New_Instance("Ink_origin", "Ink_empty", {position = {0, 0}, size = {0, 0}, value = "Ink ^^"})
    self.onHover = false
end

-- Love functions>>
function Ink:update (dt)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then

            self:Update_Parent(self.instances[instanceName], dt)
            self:Detect_Visibility(self.instances[instanceName])

            if self.instances[instanceName].isVisible then
                self:Hover(self.instances[instanceName])
                self.instances[instanceName]:Update(dt)
                if love.mouse.isDown(1) then
                    self.instances[instanceName]:MouseDown(love.mouse.getX(), love.mouse.getY(), 1)
                end
            end
        end
    end
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
                self.instances[instanceName]:Ink_Draw()
            end
        end
    end

    -- reset coordinate system
    love.graphics.pop()

    -- reset the font
    love.graphics.setFont(previousFont)
end

function Ink:mousepressed (x, y, btn, isTouch)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:MousePressed(x, y, btn)
        end
    end
end

function Ink:mousereleased (x, y, btn, isTouch)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:MouseReleased(x, y, btn)
        end
    end
end

function Ink:textinput (text)

    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:TextInput(text)
        end
    end
end

function Ink:keypressed (key, scancode, isrepeat)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:KeyPressed(key, scancode, isrepeat)
        end
    end
end

function Ink:keyreleased (key)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:KeyReleased(key)
        end
    end
end

--<<Love functions

-- Ink functions>>

function Ink:Update_Parent (v, dt)
        v.pos.x = v.posInterpolDisabled ~= true and self:BasicInterpolation(v.pos.x, v.localPos.x + v.parentPos.x, 3 * dt) or v.localPos.x + v.parentPos.x
        v.pos.y = v.posInterpolDisabled ~= true and self:BasicInterpolation(v.pos.y, v.localPos.y + v.parentPos.y, 3 * dt) or v.localPos.y + v.parentPos.y

        v.size.x = v.sizeInterpolDisabled ~= true and self:BasicInterpolation(v.size.x, v.localSize.x, 3 * dt) or v.localSize.x
        v.size.y = v.sizeInterpolDisabled ~= true and self:BasicInterpolation(v.size.y, v.localSize.y, 3 * dt) or v.localSize.y
end

function Ink:BasicInterpolation (initial, final, interpolation)
    --return (initial + final) * interpolation
    return initial + ((final - initial) * interpolation)
end

function Ink:Detect_Visibility (v)
    local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}
    v.isVisible = v.pos.x <= love.graphics.getWidth() and v.pos.y <= love.graphics.getHeight()
end

function Ink:Hover (v)
    local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}

    -- verify if the mouse is over the geometry of the instance
    local inHover = self:Detect_Hover(v.geometry, v.pos, v.size)
    if inHover then
        -- execute the Hover function of the module
        if not self.onHover then
            v:Hover()
            self.onHover = true;
        end
    else
        self.onHover = false;
        v:NotHover()
    end
    v.inHover = inHover
end

-- <<Ink functions

-- Ink functions to help you ;)>>
function Ink:Detect_Hover (type, pos, size)
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
