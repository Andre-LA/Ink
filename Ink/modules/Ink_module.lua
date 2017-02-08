-- Create modules using this as reference
local Module = {}

setmetatable(Module, {
    __call = function  (cls, ...)
        return cls:new(...)
    end
})

function Module:new (values, inkLib, name)
    -- Default properties:
    self.parent    = "Ink_origin"
    self.parentPos = {x = 0,   y = 0}
    self.pos       = {x = values.position[1],   y = values.position[2]}
    self.pivot     = {x = 0.5, y = 0.5}
    self.size      = {x = 0,   y = 0}
    self.isVisible = true
    self.geometry  = "rectangle"
    self.inHover   = false
    self.lockHover = true

    -- Variable properties:
    self.name = name
    self.value = values.value
    self.localPos = {x = values.position[1], y = values.position[2]}
    self.localSize = {x = values.size[1], y = values.size[2]}
    self.inkLib = inkLib

    self.updateList = {}
    self.drawList = {}
    self.mousepressedList = {}
    self.mousereleasedList = {}
    self.keypressedList = {}
    self.keyreleasedList = {}
    self.directorydroppedList = {}
    self.filedroppedList = {}
    self.focusList = {}
    self.lowmemoryList = {}
    self.mousefocusList = {}
    self.mousemovedList = {}
    self.mousepressedList = {}
    self.mousereleasedList = {}
    self.quitList = {}
    self.touchmovedList = {}
    self.touchpressedList = {}
    self.touchreleasedList = {}
    self.visibleList = {}
    self.wheelmovedList = {}
    self.resizeList = {}
    self.textinputList = {}
    self.texteditedList = {}
    self.gamepadaxisList = {}
    self.gamepadpressedList = {}
    self.gamepadreleasedList = {}
    self.joystickaddedList = {}
    self.joystickaxisList = {}
    self.joystickhatList = {}
    self.joystickpressedList = {}
    self.joystickreleasedList = {}
    self.joystickremovedList = {}

    -- Create extra or replace properties:
    for k,v in pairs(values) do
        if k ~= "position" and k ~= "size" and k ~= "name" and k ~= "value" then
            self[k] = v
        end
    end
end

function Module:insertupdateList (func)
    table.insert(self.updateList, func)
end

function Module:insertdrawList (func)
    table.insert(self.drawList, func)
end

function Module:insertmousepressedList (func)
    table.insert(self.mousepressedList, func)
end

function Module:insertmousereleasedList (func)
    table.insert(self.mousereleasedList, func)
end

function Module:insertkeypressedList (func)
    table.insert(self.keypressedList, func)
end

function Module:insertkeyreleasedList (func)
    table.insert(self.keyreleasedList, func)
end

function Module:insertdirectorydroppedList (func)
    table.insert(self.directorydroppedList, func)
end

function Module:insertfiledroppedList (func)
    table.insert(self.filedroppedList, func)
end

function Module:insertfocusList (func)
    table.insert(self.focusList, func)
end

function Module:insertlowmemoryList (func)
    table.insert(self.lowmemoryList, func)
end

function Module:insertmousefocusList (func)
    table.insert(self.mousefocusList, func)
end

function Module:insertmousemovedList (func)
    table.insert(self.mousemovedList, func)
end

function Module:insertmousepressedList (func)
    table.insert(self.mousepressedList, func)
end

function Module:insertmousereleasedList (func)
    table.insert(self.mousereleasedList, func)
end

function Module:insertquitList (func)
    table.insert(self.quitList, func)
end

function Module:inserttouchmovedList (func)
    table.insert(self.touchmovedList, func)
end

function Module:inserttouchpressedList (func)
    table.insert(self.touchpressedList, func)
end

function Module:inserttouchreleasedList (func)
    table.insert(self.touchreleasedList, func)
end

function Module:insertvisibleList (func)
    table.insert(self.visibleList, func)
end

function Module:insertwheelmovedList (func)
    table.insert(self.wheelmovedList, func)
end

function Module:insertresizeList (func)
    table.insert(self.resizeList, func)
end

function Module:inserttextinputList (func)
    table.insert(self.textinputList, func)
end

function Module:inserttexteditedList (func)
    table.insert(self.texteditedList, func)
end

function Module:insertgamepadaxisList (func)
    table.insert(self.gamepadaxisList, func)
end

function Module:insertgamepadpressedList (func)
    table.insert(self.gamepadpressedList, func)
end

function Module:insertgamepadreleasedList (func)
    table.insert(self.gamepadreleasedList, func)
end

function Module:insertjoystickaddedList (func)
    table.insert(self.joystickaddedList, func)
end

function Module:insertjoystickaxisList (func)
    table.insert(self.joystickaxisList, func)
end

function Module:insertjoystickhatList (func)
    table.insert(self.joystickhatList, func)
end

function Module:insertjoystickpressedList (func)
    table.insert(self.joystickpressedList, func)
end

function Module:insertjoystickreleasedList (func)
    table.insert(self.joystickreleasedList, func)
end

function Module:insertjoystickremovedList (func)
    table.insert(self.joystickremovedList, func)
end

function Module:exeupdateList (dt)
    for i=1,#self.updateList do
        if self.updateList ~= nil then
            self.updateList[i](self, dt)
        end
    end
end
function Module:exedrawList ()
    for i=1,#self.drawList do
        if self.drawList ~= nil then
            self.drawList[i](self)
        end
    end
end
function Module:exemousepressedList (x, y, button, istouch)
    for i=1,#self.mousepressedList do
        if self.mousepressedList ~= nil then
            self.mousepressedList[i](self, x, y, button, istouch)
        end
    end
end
function Module:exemousereleasedList (x, y, button, istouch)
    for i=1,#self.mousereleasedList do
        if self.mousereleasedList ~= nil then
            self.mousereleasedList[i](self, x, y, button, istouch)
        end
    end
end
function Module:exekeypressedList (key, scancode, isrepeat)
    for i=1,#self.keypressedList do
        if self.keypressedList ~= nil then
            self.keypressedList[i](self, key, scancode, isrepeat)
        end
    end
end
function Module:exekeyreleasedList (key)
    for i=1,#self.keyreleasedList do
        if self.keyreleasedList ~= nil then
            self.keyreleasedList[i](self, key)
        end
    end
end
function Module:exedirectorydroppedList ()
    for i=1,#self.directorydroppedList do
        if self.directorydroppedList ~= nil then
            self.directorydroppedList[i](self)
        end
    end
end
function Module:exefiledroppedList (file)
    for i=1,#self.filedroppedList do
        if self.filedroppedList ~= nil then
            self.filedroppedList[i](self, file)
        end
    end
end
function Module:exefocusList (focus)
    for i=1,#self.focusList do
        if self.focusList ~= nil then
            self.focusList[i](self, focus)
        end
    end
end
function Module:exelowmemoryList ()
    for i=1,#self.lowmemoryList do
        if self.lowmemoryList ~= nil then
            self.lowmemoryList[i](self)
        end
    end
end
function Module:exemousefocusList (focus)
    for i=1,#self.mousefocusList do
        if self.mousefocusList ~= nil then
            self.mousefocusList[i](self, focus)
        end
    end
end
function Module:exemousemovedList (x, y, dx, dy, istouch)
    for i=1,#self.mousemovedList do
        if self.mousemovedList ~= nil then
            self.mousemovedList[i](self, x, y, dx, dy, istouch)
        end
    end
end
function Module:exemousepressedList (x, y, button, istouch)
    for i=1,#self.mousepressedList do
        if self.mousepressedList ~= nil then
            self.mousepressedList[i](self, x, y, button, istouch)
        end
    end
end
function Module:exemousereleasedList (x, y, button, istouch)
    for i=1,#self.mousereleasedList do
        if self.mousereleasedList ~= nil then
            self.mousereleasedList[i](self, x, y, button, istouch)
        end
    end
end
function Module:exequitList()
    for i=1,#self.quitList do
        if self.quitList ~= nil then
            self.quitList[i](self)
        end
    end
end
function Module:exetouchmovedList (id, x, y, dx, dy, pressure)
    for i=1,#self.touchmovedList do
        if self.touchmovedList ~= nil then
            self.touchmovedList[i](self, id, x, y, dx, dy, pressure)
        end
    end
end
function Module:exetouchpressedList (id, x, y, dx, dy, pressure)
    for i=1,#self.touchpressedList do
        if self.touchpressedList ~= nil then
            self.touchpressedList[i](self, id, x, y, dx, dy, pressure)
        end
    end
end
function Module:exetouchreleasedList (id, x, y, dx, dy, pressure)
    for i=1,#self.touchreleasedList do
        if self.touchreleasedList ~= nil then
            self.touchreleasedList[i](self, id, x, y, dx, dy, pressure)
        end
    end
end
function Module:exevisibleList(visible)
    for i=1,#self.visibleList do
        if self.visibleList ~= nil then
            self.visibleList[i](self, visible)
        end
    end
end
function Module:exewheelmovedList (x, y)
    for i=1,#self.wheelmovedList do
        if self.wheelmovedList ~= nil then
            self.wheelmovedList[i](self, x, y)
        end
    end
end
function Module:exeresizeList(w, h)
    for i=1,#self.resizeList do
        if self.resizeList ~= nil then
            self.resizeList[i](self, w, h)
        end
    end
end
function Module:exetextinputList (text)
    for i=1,#self.textinputList do
        if self.textinputList ~= nil then
            self.textinputList[i](self, text)
        end
    end
end
function Module:exetexteditedList (text, start, length)
    for i=1,#self.texteditedList do
        if self.texteditedList ~= nil then
            self.texteditedList[i](self, text, start, length)
        end
    end
end
function Module:exegamepadaxisList (joystick, axis, value)
    for i=1,#self.gamepadaxisList do
        if self.gamepadaxisList ~= nil then
            self.gamepadaxisList[i](self, joystick, axis, value)
        end
    end
end
function Module:exegamepadpressedList (joystick, button)
    for i=1,#self.gamepadpressedList do
        if self.gamepadpressedList ~= nil then
            self.gamepadpressedList[i](self, joystick, button)
        end
    end
end
function Module:exegamepadreleasedList (joystick, button)
    for i=1,#self.gamepadreleasedList do
        if self.gamepadreleasedList ~= nil then
            self.gamepadreleasedList[i](self, joystick, button)
        end
    end
end
function Module:exejoystickaddedList (joystick)
    for i=1,#self.joystickaddedList do
        if self.joystickaddedList ~= nil then
            self.joystickaddedList[i](self, joystick)
        end
    end
end
function Module:exejoystickaxisList (joystick, axis, value)
    for i=1,#self.joystickaxisList do
        if self.joystickaxisList ~= nil then
            self.joystickaxisList[i](self, joystick, axis, value)
        end
    end
end
function Module:exejoystickhatList (joystick, hat, direction)
    for i=1,#self.joystickhatList do
        if self.joystickhatList ~= nil then
            self.joystickhatList[i](self, joystick, hat, direction)
        end
    end
end
function Module:exejoystickpressedList (joystick, button)
    for i=1,#self.joystickpressedList do
        if self.joystickpressedList ~= nil then
            self.joystickpressedList[i](self, joystick, button)
        end
    end
end
function Module:exejoystickreleasedList (joystick, button)
    for i=1,#self.joystickreleasedList do
        if self.joystickreleasedList ~= nil then
            self.joystickreleasedList[i](self, joystick, button)
        end
    end
end
function Module:exejoystickremovedList (joystick)
    for i=1,#self.joystickremovedList do
        if self.joystickremovedList ~= nil then
            self.joystickremovedList[i](self, joystick)
        end
    end
end

function Module:getGlobalPosition ()
    return self.pos.x, self.pos.y
end

function Module:getLocalPosition ()
    return self.localPos.x, self.localPos.y
end

function Module:setPosition (x, y)
    self.localPos.x = x
    self.localPos.y = y
end

function Module:translate (x, y)
    self.localPos.x = self.localPos.x + x
    self.localPos.y = self.localPos.y + y
end

function Module:getGlobalSize ()
    return self.size.x, self.size.y
end

function Module:getLocalSize ()
    return self.localSize.x, self.localSize.y
end

function Module:setSize (x, y)
    self.localSize.x = x
    self.localSize.y = y
end

function Module:resize (x, y)
    self.localSize.x = self.localSize.x + x
    self.localSize.y = self.localSize.y + y
end

function Module:setParent (name)
    self.parent = name;
end

function Module:hover () end
function Module:nothover () end
function Module:mousedown (x, y, b) end

function Module:update (dt) end
function Module:draw () end
function Module:mousepressed (x, y, button, istouch) end
function Module:mousereleased (x, y, button, istouch) end
function Module:keypressed (key, scancode, isrepeat) end
function Module:keyreleased (key) end
function Module:directorydropped () end
function Module:filedropped (file) end
function Module:focus (focus) end
function Module:lowmemory () end
function Module:mousefocus (focus) end
function Module:mousemoved (x, y, dx, dy, istouch) end
function Module:mousepressed (x, y, button, istouch) end
function Module:mousereleased (x, y, button, istouch) end
function Module:quit() end
function Module:touchmoved (id, x, y, dx, dy, pressure) end
function Module:touchpressed (id, x, y, dx, dy, pressure) end
function Module:touchreleased (id, x, y, dx, dy, pressure) end
function Module:visible(visible) end
function Module:wheelmoved (x, y) end
function Module:resize(w, h) end
function Module:textinput (text) end
function Module:textedited (text, start, length) end
function Module:gamepadaxis (joystick, axis, value) end
function Module:gamepadpressed (joystick, button) end
function Module:gamepadreleased (joystick, button) end
function Module:joystickadded (joystick) end
function Module:joystickaxis (joystick, axis, value) end
function Module:joystickhat (joystick, hat, direction) end
function Module:joystickpressed (joystick, button) end
function Module:joystickreleased (joystick, button) end
function Module:joystickremoved (joystick) end

function Module:getValue ()
    return self.value
end

function Module:setValue (newValue)
    self.value = newValue
end

return Module
