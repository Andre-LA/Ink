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
    self.font = love.graphics.newFont("Ink/fonts/FreeSans.ttf", 14)
    self.onHover = false

    self:New_Instance("Ink_origin", "Ink_empty", {positionX = 0, positionY = 0, sizeX = 0, sizeY = 0, value = "Ink ^^"})

    setmetatable(nw, {__index = self})
    return nw
end

function Ink:New_Instance (instance_name, module_name, inicial_values, parentName)
    -- This will execute the module file and execute the Ink_Start function of the module
    self.instances[instance_name] = assert( love.filesystem.load( "Ink/modules/" .. module_name .. ".lua" ) )() -- same, dofile ("Ink/modules/" .. module_name .. ".lua"), but dofile not working well in love2d
    self.instances[instance_name]:Ink_Start(inicial_values, self)

    if parentName ~= nil then
        self.instances[instance_name]:Set_Parent(parentName)
    elseif instance_name ~= "Ink_origin" then
        self.instances[instance_name]:Set_Parent("Ink_origin")
    end
end


-- Love functions>>
function Ink:Update (dt)
    for k,v in pairs(self.instances) do
        self:Update_Parent(v, dt)
        self:Detect_Visibility(v)

        if v.isVisible then
            self:Hover(v)
            v:Update(dt)
            if love.mouse.isDown(1) then
                v:MouseDown(love.mouse.getX(), love.mouse.getY(), 1)
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

    for k,v in pairs(self.instances) do
        if v.isVisible then
            v:Ink_Draw()
        end
    end

    -- reset coordinate system
    love.graphics.pop()

    -- reset the font
    love.graphics.setFont(previousFont)
end

function Ink:MousePressed (x, y, btn, isTouch)
    for k,v in pairs(self.instances) do
        local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}
        v:MousePressed(x, y, btn)
    end
end

function Ink:MouseReleased (x, y, btn, isTouch)
    for k,v in pairs(self.instances) do
        local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}
        v:MouseReleased(x, y, btn)
    end
end

function Ink:TextInput (text)
    for k,v in pairs(self.instances) do
        v:TextInput(text)
    end
end

function Ink:Keypressed (key, scancode, isrepeat)
    for k,v in pairs(self.instances) do
        v:KeyPressed(key, scancode, isrepeat)
    end
end

function Ink:Keyreleased (key)
    for k,v in pairs(self.instances) do
        v:KeyReleased(key)
    end
end

--<<Love functions

-- Ink functions>>

function Ink:Update_Parent (v, dt)
    v.parentPos = self.instances[v.parent].pos
    v.pos.x = self:BasicInterpolation(v.pos.x, v.localPos.x + v.parentPos.x, 0.5)
    v.pos.y = self:BasicInterpolation(v.pos.y, v.localPos.y + v.parentPos.y, 0.5)
end

function Ink:BasicInterpolation (initial, final, interpolation)
    return (initial + final) * interpolation
end

function Ink:Detect_Visibility (v)
    local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}
    local distX = v.pos.x + parentPos.x
    local distY = v.pos.y + parentPos.y

    v.isVisible = distX <= love.graphics.getWidth() and distY <= love.graphics.getHeight()
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
