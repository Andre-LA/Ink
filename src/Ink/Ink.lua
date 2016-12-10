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
-- Ink by Andre-LA, member of Love2D Brasil group

local Ink = {}

function Ink:Ink ()
    local nw = {}

    self.instances = {}
    self.instancesOrder = {}
    self.font = love.graphics.newFont("Ink/fonts/FreeSans.ttf", 18)
    self.onHover = false

    self.safeDelete = false

    self:New_Instance("Ink_origin", "Ink_empty", {position = {0, 0}, size = {0, 0}, value = "Ink ^^"})

    setmetatable(nw, {__index = self})
    return nw
end

function Ink:New_Instance (instance_name, module_name, inicial_values, parentName)
    -- This will execute the module file and execute the Ink_Start function of the module
    self.instances[instance_name] = assert( love.filesystem.load( "Ink/modules/" .. module_name .. ".lua" ) )() -- same, dofile ("Ink/modules/" .. module_name .. ".lua"), but dofile not working well in love2d
    self.instances[instance_name]:Ink_Start(inicial_values, self)
    table.insert(self.instancesOrder, instance_name)

    if parentName ~= nil then
        self.instances[instance_name]:Set_Parent(parentName)
    elseif instance_name ~= "Ink_origin" then
        self.instances[instance_name]:Set_Parent("Ink_origin")
    end

    self.instances[instance_name].pos.x = self.instances[self.instances[instance_name].parent].pos.x
    self.instances[instance_name].pos.y = self.instances[self.instances[instance_name].parent].pos.y
end

function Ink:Delete_All_Instances ()
    self.instances = {}
    self.instancesOrder = {}
    self:New_Instance("Ink_origin", "Ink_empty", {position = {0, 0}, size = {0, 0}, value = "Ink ^^"})
    self.onHover = false
end

-- Love functions>>
function Ink:Update (dt)
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

function Ink:Draw ()
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

function Ink:MousePressed (x, y, btn, isTouch)

    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:MousePressed(x, y, btn)
        end
    end
end

function Ink:MouseReleased (x, y, btn, isTouch)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:MouseReleased(x, y, btn)
        end
    end
end

function Ink:TextInput (text)

    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:TextInput(text)
        end
    end
end

function Ink:Keypressed (key, scancode, isrepeat)
    for i=1,#self.instancesOrder do
        local instanceName = self.instancesOrder[i]
        if instanceName ~= nil then
            self.instances[instanceName]:KeyPressed(key, scancode, isrepeat)
        end
    end
end

function Ink:Keyreleased (key)
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
    v.parentPos = self.instances[v.parent].pos

    if (v.posInterpolDisabled ~= true) then
        v.pos.x = self:BasicInterpolation(v.pos.x, v.localPos.x + v.parentPos.x, 3 * dt)
        v.pos.y = self:BasicInterpolation(v.pos.y, v.localPos.y + v.parentPos.y, 3 * dt)
    else
        v.pos.x = v.localPos.x + v.parentPos.x
        v.pos.y = v.localPos.y + v.parentPos.y
    end

    if (v.sizeInterpolDisabled ~= true) then
        if type(v.size) == "table" then
            v.size.x = self:BasicInterpolation(v.size.x, v.localSize.x, 3 * dt)
            v.size.y = self:BasicInterpolation(v.size.y, v.localSize.y, 3 * dt)
        else
            v.size = self:BasicInterpolation(v.size, v.localSize, 3 * dt)
        end
    else
        if type(v.size) == "table" then
            v.size.x = v.localSize.x
            v.size.y = v.localSize.y
        else
            v.size = v.localSize
        end
    end
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
        + math.pow(math.abs(mousePosy - pos.y), 2)) <= size then
            ret = true
        end
    end

    return ret
end
-- <<Ink functions to help you ;)

return Ink:Ink()
