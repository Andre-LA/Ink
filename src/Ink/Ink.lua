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
end

function Ink:New_Instance (instance_name, module_name, inicial_values)
    -- This will execute the module file and execute the Ink_Start function of the module
    self.instances[instance_name] = dofile ("Ink/modules/" .. module_name .. ".lua")
    self.instances[instance_name]:Ink_Start(inicial_values[1], inicial_values[2], inicial_values[3])
end


-- Love callbacks>>
function Ink:Update (dt)
    self:Hover()
    for k,v in pairs(self.instances) do
        self.instances[k]:Update()
    end
end

function Ink:Draw ()
    local previousFont = love.graphics.getFont()
    love.graphics.setFont(self.font)

    for k,v in pairs(self.instances) do
        self.instances[k]:Ink_Draw()
    end

    love.graphics.setFont(previousFont)
end

function Ink:MousePressed (x, y, btn, isTouch)
    for k,v in pairs(self.instances) do
        if self:VerifyHover(self.instances[k].geometry, self.instances[k].pos, self.instances[k].size) then
            self.instances[k]:MousePressed(x, y, btn)
        end
    end
end

function Ink:MouseReleased (x, y, btn, isTouch)
    for k,v in pairs(self.instances) do
        if self:VerifyHover(self.instances[k].geometry, self.instances[k].pos, self.instances[k].size) then
            self.instances[k]:MouseReleased(x, y, btn)
        end
    end
end

--<<Love callbacks

-- Ink callbacks>>

function Ink:Hover ()
    for k,v in pairs(self.instances) do
        -- verify the type of geometry
        --love.window.setTitle(self.instances[k].pos[1])
        -- verify if the mouse is over the geometry of the instance
        if self:VerifyHover(self.instances[k].geometry, self.instances[k].pos, self.instances[k].size) then
            -- execute the Hover function of the module
            self.instances[k]:Hover()
        else
            self.instances[k]:NotHover()
        end
    end
end

-- <<Ink callbacks

-- Ink functions to help you ;)>>
function Ink:VerifyHover (type, pos, size)
    local mousePosx, mousePosy = love.mouse.getPosition()
    local ret = false;

    if type == "rectangle" then
        if (mousePosx > pos.x and mousePosx < pos.x + size.x) and
        (mousePosy > pos.y and mousePosy < pos.y + size.y) then
            ret = true
        end
    elseif type == "circle" then
        if math.sqrt(math.pow(math.abs(mousePosx - pos.x), 2) + math.pow(math.abs(mousePosy - pos.y), 2)) <= size then
            ret = true
        end
    end

    return ret
end
-- <<Ink functions to help you ;)


return Ink()
