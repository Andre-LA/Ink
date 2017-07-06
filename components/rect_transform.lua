return function(parameters)
    return {
        position = parameters.position or {x = 0, y = 0, z = 0},
        scale    = parameters.scale    or {x = 0, y = 0},
        anchors  = parameters.anchors  or {up = 1, left = 1, right = 1, down = 1},
        offset   = parameters.offset   or {up = 0, left = 0, right = 0, down = 0},
        useTween = parameters.useTween or true,
        velocity = parameters.velocity or 5
    }
end
