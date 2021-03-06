return function (parameters)
    local finalParameters = {
        posY      = 0,
        font      = parameters.font     or love.graphics.getFont(),
        text      = parameters.text     or "",
        scale     = parameters.scale    or {x=1, y=1},
        offsets   = parameters.offsets  or {x=0, y=0},
        rotation  = parameters.rotation or 0,
        shearing  = parameters.shearing or {x=0, y=0},
        editable  = parameters.editable or false,
        inEdit    = false,
        multiLine = true,
        editBgColor       = parameters.editBgColor       or {0,0,0,50},
        verticalAlign     = parameters.verticalAlign     or "up",
        horizontalAlign   = parameters.horizontalAlign   or "left",
        useMultipleColors = parameters.useMultipleColors or false,
    }

    if parameters.useMultipleColors then
        finalParameters.colors = parameters.colors or {{255,255,255,255}}
        assert(parameters.multipleColorsIndexes, [[multipleColorsIndexes is nil, please provide one.
            Example: {2, 4, 8}
            Must be the same size of colors (#multipleColorsIndexes == #colors must return true)]]
        )
        finalParameters.multipleColorsIndexes = parameters.multipleColorsIndexes
    else
        finalParameters.color = parameters.color or {255,255,255,255}
    end

    assert( -- assert on horizontalAlign
        finalParameters.horizontalAlign == "left"
        or finalParameters.horizontalAlign == "center"
        or finalParameters.horizontalAlign == "right"
        or finalParameters.horizontalAlign == "justify"
        ,
        'horizontalAlign must be "left", "center", "right" or justify')

    assert( -- assert on verticalAlign
        finalParameters.verticalAlign == "up"
        or finalParameters.verticalAlign == "center"
        or finalParameters.verticalAlign == "down"
        ,
        'verticalAlign must be "up", "center" or "down"'
    )

    return finalParameters
end
