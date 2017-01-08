local Textbox = assert(love.filesystem.load("Ink/modules/Ink_module.lua"))()
function Textbox:Start(values, inkLib, name)
    Textbox(values, inkLib, name)
    self.colors = {
        txtArea = {250, 250, 250, 255},
        txtOutline = {150, 150, 150, 255},
        txtBackColor = {0, 0, 0, 40},
        txtColor = {50, 50, 50, 255}
    }

    self.outlineSize = 5;
    self.isActive = false
    self.deltaTime = 0
end

function Textbox:Update (dt)
    if isActive then
        self.deltaTime = self.deltaTime + dt

        if self.deltaTime > 0.6 then
            self.deltaTime = 0
            self.colors.txtBackColor[4] = self.colors.txtBackColor[4] == 40 and 0 or 40
        end
    end
end

function Textbox:MousePressed (x, y, b)
    if self.inHover and self.isActive == not self.inHover then
        self.outlineSize = self.outlineSize * 1.5

        for i=1,#self.colors.txtOutline do
            self.colors.txtOutline[i] = self.colors.txtOutline[i] - 20
        end

    elseif not self.inHover and self.isActive == not self.inHover then
        self.outlineSize = self.outlineSize / 1.5

        for i=1,#self.colors.txtOutline do
            self.colors.txtOutline[i] = self.colors.txtOutline[i] + 20
        end
    end

    self.isActive = self.inHover
end

function Textbox:TextInput (text)
    self.value = self.value .. text
end

function Textbox:KeyPressed (key, scancode, isrepeat)
    if key == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(self.value, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            self.value = string.sub(self.value, 1, byteoffset - 1)
        end
    end
end

function Textbox:Ink_Draw ()
    -- Draw fist background, this background will be the outline
    love.graphics.setColor(self.colors.txtOutline)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)

    -- Draw the background
    love.graphics.setColor(self.colors.txtArea)
    love.graphics.rectangle("fill", self.pos.x  + self.outlineSize/2, self.pos.y  + self.outlineSize/2, self.size.x - self.outlineSize , self.size.y - self.outlineSize )

    -- if active (edit mode), draw the cursor
    if self.isActive then
        love.graphics.setColor(self.colors.txtBackColor)
        love.graphics.rectangle("fill", self.pos.x + self.outlineSize + 10 + love.graphics.getFont():getWidth(self.value), self.pos.y + self.size.y/2 - (love.graphics.getFont():getHeight("a")/2), love.graphics.getFont():getWidth("a")/2, love.graphics.getFont():getHeight(self.value))
    end

    -- Draw the text
    love.graphics.setColor(self.colors.txtColor)
    love.graphics.print(self.value, self.pos.x + self.outlineSize + 10, self.pos.y + self.size.y/2 - (love.graphics.getFont():getHeight("a")/2))
end

return Textbox
