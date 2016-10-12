require "lclass/class"
class "Ink"

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

function Ink:Ink ()
    self.instances = {}
    self.font = love.graphics.newFont("Ink/fonts/FreeSans.ttf", 14)
    self.onHover = false
end

function Ink:New_Instance (instance_name, module_name, inicial_values, parentName)
    -- This will execute the module file and execute the Ink_Start function of the module
    self.instances[instance_name] = dofile ("Ink/modules/" .. module_name .. ".lua")
    self.instances[instance_name]:Ink_Start(inicial_values, self)

    if parentName ~= nil then
        self.instances[instance_name]:Set_Parent(parentName)
    end
end


-- Love callbacks>>
function Ink:Update (dt)
    for k,v in pairs(self.instances) do
        if v.parent ~= "" then
            v:Update_Parent(self.instances[v.parent].pos)
        end

        self:Detect_Visibility(v)
        if v.isVisible then
            self:Hover(v)
            v:Update()
        end
    end
end

function Ink:Draw ()
    -- reset coordinate system
    love.graphics.push()
    love.graphics.origin()

    local previousFont = love.graphics.getFont()
    love.graphics.setFont(self.font)

    for k,v in pairs(self.instances) do
        if v.isVisible then
            v:Ink_Draw()
        end
    end

    -- reset coordinate system
    love.graphics.pop()
    love.graphics.setFont(previousFont)
end

function Ink:MousePressed (x, y, btn, isTouch)
    for k,v in pairs(self.instances) do
        local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}

        if self:Detect_Hover(v.geometry, v.pos, v.size, parentPos) then
            v:MousePressed(x, y, btn)
        end
    end
end

function Ink:MouseReleased (x, y, btn, isTouch)
    for k,v in pairs(self.instances) do
        local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}

        if self:Detect_Hover(v.geometry, v.pos, v.size, parentPos) then
            v:MouseReleased(x, y, btn)
        end
    end
end

--<<Love callbacks

-- Ink callbacks>>

function Ink:Detect_Visibility (v)
    local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}
    local distX = v.pos.x + parentPos.x
    local distY = v.pos.y + parentPos.y

    v.isVisible = distX <= love.graphics.getWidth() and distY <= love.graphics.getHeight()
end

function Ink:Hover (v)
    local parentPos = v.parent ~= "" and self.instances[v.parent].pos or {x = 0, y = 0}

    -- verify if the mouse is over the geometry of the instance
    if self:Detect_Hover(v.geometry, v.pos, v.size, parentPos) then
        -- execute the Hover function of the module
        if not self.onHover then
            v:Hover()
            self.onHover = true;
        end
    else
        self.onHover = false;
        v:NotHover()
    end
end

-- <<Ink callbacks

-- Ink functions to help you ;)>>
function Ink:Detect_Hover (type, pos, size, parentPos)
    local mousePosx, mousePosy = love.mouse.getPosition()
    local ret = false;

    if type == "rectangle" then
        if (mousePosx > pos.x + parentPos.x and mousePosx < pos.x + size.x + parentPos.x) and
        (mousePosy > pos.y + parentPos.y and mousePosy < pos.y + size.y + parentPos.y) then
            ret = true
        end
    elseif type == "circle" then
        if math.sqrt(math.pow(math.abs(mousePosx - pos.x + parentPos.x), 2)
        + math.pow(math.abs(mousePosy - pos.y + parentPos.y), 2)) <= size then
            ret = true
        end
    end

    return ret
end
-- <<Ink functions to help you ;)


return Ink()
