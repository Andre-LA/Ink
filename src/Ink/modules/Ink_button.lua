--module "Ink_button"
local Module = {}

function Module:New()
    -- ink properties:
    self.parent    = "Ink_origin"
    self.parentPos = {x = 0, y = 0}
    self.localPos  = {x = 0, y = 0}
    self.pos       = {x = 0, y = 0}
    self.localSize = {x = 0, y = 0}
    self.size      = {x = 0, y = 0}
    self.isVisible = true
    self.geometry  = "rectangle"
    self.value     = function  ()

    end
    self.inHover   = false

    -- My properties
    self.pivot = {x = 0.5, y = 0.5}
    self.text = "a button"

    self.colors = {
        {250, 250, 250},
        {100, 100, 200},
        {150, 150, 220},
        {80, 80, 150}
    }

    self.button_color = self.colors[2]
    self.text_color = self.colors[1]

    local nw = {}
    setmetatable(nw, {__index = self})
    return nw
end

function Module:Set_Parent (name)
    self.parent = name;
end

function Module:Ink_Start (values, inkLib)
    self.inkLib = inkLib

    self.localPos.x = values.position[1]
    self.localPos.y = values.position[2]
    self.localSize.x = values.size[1]
    self.localSize.y = values.size[2]
    self.text = values.text
    self.value = values.value;
end

function Module:Update (dt)
    -- If you will not use a function, you can write nothing inside, but is obrigatory the module have the function

end

function Module:Hover ()
    if self.button_color ~= self.colors[4] then
        self.button_color = self.colors[3]
    end
end

function Module:NotHover ()
    self.button_color = self.colors[2]
end

function Module:MousePressed (x, y, b)
    if self.inHover then
        self.button_color = self.colors[4]
        self.value()
    end
end

function Module:MouseDown (x, y, b)

end

function Module:MouseReleased (x, y, b)
    if self.inHover then
        self.button_color = self.colors[3]
    end
end

function Module:TextInput (text)

end

function Module:KeyPressed (key, scancode, isrepeat)

end

function Module:KeyReleased (key)

end

function Module:Ink_Draw ()
    -- Draw button background
    love.graphics.setColor(self.button_color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    -- Draw button text, the text position = button position + (button size * pivot) - half size of the button text
    love.graphics.setColor(self.text_color)
    love.graphics.print(self.text, self.pos.x + (self.size.x * self.pivot.x) - (love.graphics.getFont():getWidth(self.text)/2), self.pos.y + (self.size.y * self.pivot.y) - (love.graphics.getFont():getHeight("a")/2))
end

function Module:GetValue ()
    return self.value
end

function Module:SetValue (newValue)
    self.value = newValue
end

function Module:Set_Text (text)
    self.text = type(text) == "string" and text or tostring(text)
end

return Module:New()
