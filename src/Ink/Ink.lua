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
end

function Ink:New_Instance (instance_name, module_name, inicial_values)
    -- This will execute the module file and execute the Ink_Start function of the module
    self.instances[instance_name] = dofile ("Ink/modules/" .. module_name .. ".lua")
    self.instances[instance_name]:Ink_Start(inicial_values[1], inicial_values[2], inicial_values[3])
end


-- Love callbacks>>
function Ink:Update (dt)
    self:Hover()
end

function Ink:Draw ()
    for k,v in pairs(self.instances) do
        self.instances[k]:Ink_Draw()
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

-- future functions on Ink: :MouseClick(b), :MouseClickDown(b), :MouseClickUp(b)
-- :MouseClick só é executada quando mouse é clicado e está hover ;)

















return Ink()
