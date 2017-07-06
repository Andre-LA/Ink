return function (parameters)
    return {
        color          = parameters.color          or {255,255,255,0},
        mouseOverColor = parameters.mouseOverColor or {255,255,255,80},
        onClickColor   = parameters.onClickColor   or {0,0,0,80},
        onClick        = parameters.onClick        or function() end,
        offClick       = parameters.offClick       or function() end,
        isMouseOver    = false,
        finalColor     = {0,0,0,255},
        clickable      = parameters.clickable or true,
    }
end
