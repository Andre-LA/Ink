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
    self.instances[instance_name]:Start(inicial_values[1], inicial_values[2], inicial_values[3])
end

function Ink:Draw ()
    for k,v in pairs(self.instances) do
        self.instances[k]:Ink_Draw()
    end
end

















return Ink()
