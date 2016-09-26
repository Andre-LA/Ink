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

-- Ïnk callbacks>>

function Ink:Hover ()
    for k,v in pairs(self.instances) do
        if (self.instances[k]:Ink_VerifyHover()) then
            self.instances[k]:Hover()
            if (love.mouse.isDown(1)) then
                self.instances[k]:MouseClickDown(1)
            end
        else
            self.instances[k]:NotHover()
        end
    end
end

-- <<Ïnk callbacks



-- future functions on Ink: :hover, :MouseClick(b), :MouseClickDown(b), :MouseClickUp(b)
-- :MouseClick só é executada quando mouse é clicado e está hover ;)

















return Ink()
