local text = {}
text.__index = text
local _type = type

function text.new()
    local self = {
        entities = {},
        name = "text"
    }
    setmetatable(self, text)
    return self
end

function text.applyParameters(parameters)
    local finalParameters = {
        posY     = 0,
        font     = parameters.font     or love.graphics.getFont(),
        text     = parameters.text     or "",
        color    = parameters.color    or {255,255,255,255},
        scale    = parameters.scale    or {x=1, y=1},
        offsets  = parameters.offsets  or {x=0, y=0},
        rotation = parameters.rotation or 0,
        shearing = parameters.shearing or {x=0, y=0},
        editable = parameters.editable or false,
        inEdit   = false,
        editBgColor     = parameters.editBgColor or {0,0,0,100},
        verticalAlign   = parameters.verticalAlign   or "up",
        horizontalAlign = parameters.horizontalAlign or "left",
    }

    return finalParameters
end

local function _getStringsFromTable (text_table)
    local res = ""
    for i=2,#text_table,2 do
        res = res .. text_table[i]
    end
    return res
end

function text.toggleEdit(entity)
    entity.text.inEdit = not entity.text.inEdit
end

function text.update (ink, entity, dt)
    local text_compo = entity.text

    if text_compo.verticalAlign == "up" then
        text_compo.posY = entity.rect_transform.position.y
    elseif text_compo.verticalAlign == "center" then
        text_compo.posY = entity.rect_transform.position.y
                            + entity.rect_transform.scale.y/2
                            - text_compo.font:getHeight()/2
    end
end

function text.draw(ink, entity)
    local text_compo = entity.text
    local rect_transform = entity.rect_transform

    love.graphics.setFont(text_compo.font)

    if text_compo.inEdit then
        love.graphics.setColor(text_compo.editBgColor)

        local font_height = text_compo.font:getHeight()
        local width, lines = text_compo.font:getWrap(
                                                        (_type(text_compo.text) == "table"
                                                            and _getStringsFromTable(text_compo.text)
                                                            or text_compo.text
                                                        ),
                                                        rect_transform.scale.x
                                                    )
        love.graphics.rectangle(
            "fill",
            rect_transform.position.x + text_compo.offsets.x + (rect_transform.scale.x-width)/2,
            text_compo.posY - text_compo.offsets.y,
            width,
            font_height * #lines
        )
    end

    love.graphics.setColor(text_compo.color)

    love.graphics.printf(
        text_compo.text,
        rect_transform.position.x,
        text_compo.posY,
        rect_transform.scale.x,
        text_compo.horizontalAlign,
        text_compo.rotation,
        text_compo.scale.x,
        text_compo.scale.y,
        text_compo.offsets.x,
        text_compo.offsets.y,
        text_compo.shearing.x,
        text_compo.shearing.y
    )
end

return text
