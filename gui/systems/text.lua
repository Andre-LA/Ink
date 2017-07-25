local text = {}
text.__index = text
local _utf8 = require "utf8"
local _string_sub = string.sub
local _floor = math.floor

function text.new()
    local self = {
        entities = {},
        name = "text",
        requires = {"text", "rect_transform"},
    }
    setmetatable(self, text)
    return self
end

local function _mountTextColorsTable (text_to_split, colors, text_indexes)
    local _utf8_sub = function(i, j)
        i = _utf8.offset(text_to_split, i)
        j = _utf8.offset(text_to_split, j+1)
        if i and j then
            return _string_sub(text_to_split, i, j - 1)
        end
    end

    local finalTxClsTable = {}
    local previous = 1
    for i=1,#text_indexes do
        local text_index = text_indexes[i]

        local sliced_text = i < #text_indexes
                                and _utf8_sub(previous, text_index)
                                or _utf8_sub(previous, _utf8.len(text_to_split))

        if sliced_text then
            finalTxClsTable[#finalTxClsTable+1] = colors[i]
            finalTxClsTable[#finalTxClsTable+1] = sliced_text
            previous = _utf8.len(sliced_text)+1
        end
    end

    return finalTxClsTable
end


function text.toggleEdit(entity)
    entity.text.inEdit = not entity.text.inEdit
end

function text.update (entity)
    if entity.text.verticalAlign == "up" then
        entity.text.posY = entity.rect_transform.position.y
    elseif entity.text.verticalAlign == "center" then
        local _, lines = entity.text.font:getWrap(entity.text.text, entity.rect_transform.scale.x)

        entity.text.posY = entity.rect_transform.position.y
                            + entity.rect_transform.scale.y/2
                            - (entity.text.font:getHeight() * #lines) / 2
    else -- when "down"
        local _, lines = entity.text.font:getWrap(entity.text.text, entity.rect_transform.scale.x)

        entity.text.posY = entity.rect_transform.position.y
                            + entity.rect_transform.scale.y
                            - entity.text.font:getHeight() * #lines
    end
end

function text.draw(entity)
    love.graphics.setFont(entity.text.font)

    if entity.text.inEdit then
        love.graphics.setColor(entity.text.editBgColor)

        local font_height = entity.text.font:getHeight()
        local width, lines = entity.text.font:getWrap(entity.text.text, entity.rect_transform.scale.x)

        local align_x_offset = 0 -- 0 when entity.text.horizontalAlign = "left"
        if entity.text.horizontalAlign == "center" then
            align_x_offset = entity.rect_transform.scale.x / 2 - width / 2
        elseif entity.text.horizontalAlign == "right" then
            align_x_offset = entity.rect_transform.scale.x - width
        end

        love.graphics.rectangle(
            "fill",
            entity.rect_transform.position.x + entity.text.offsets.x + align_x_offset,
            entity.text.posY + entity.text.offsets.y,
            entity.text.horizontalAlign ~= "justify" and width or entity.rect_transform.scale.x,
            font_height * #lines
        )
    end

    local text_draw

    if entity.text.useMultipleColors then
        love.graphics.setColor(255, 255, 255, 255)
        text_draw = _mountTextColorsTable(entity.text.text, entity.text.colors, entity.text.multipleColorsIndexes)
    else
        love.graphics.setColor(entity.text.color)
        text_draw = entity.text.text
    end

    love.graphics.printf(
        text_draw,
        _floor(entity.rect_transform.position.x),
        _floor(entity.text.posY),
        entity.rect_transform.scale.x,
        entity.text.horizontalAlign,
        entity.text.rotation,
        entity.text.scale.x,
        entity.text.scale.y,
        _floor(-entity.text.offsets.x),
        _floor(-entity.text.offsets.y),
        entity.text.shearing.x,
        entity.text.shearing.y
    )
end

function text.keypressed(entity, _, scancode)
    if not (entity.text.editable and entity.text.inEdit) then
        return
    end

    if scancode == "backspace" then
        local byteoffset = _utf8.offset(entity.text.text, -1)
        if byteoffset then
            entity.text.text = _string_sub(entity.text.text, 1, byteoffset - 1)
        end
    elseif entity.text.multiLine and (scancode == "return" or scancode == "kpenter") then
        entity.text.text = entity.text.text .. "\n"
    end
end

function text.textinput(entity, text_input)
    if not (entity.text.editable and entity.text.inEdit) then
        return
    end
    entity.text.text = entity.text.text .. text_input
end

return text
