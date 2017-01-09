-- Create modules using this as reference
Ink_empty = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
function Ink_empty:start (values, inkLib, name)
    Ink_empty(values, inkLib, name)
end

return Ink_empty
