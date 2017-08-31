return function  (parameters)
    return {
        position = parameters.position or {x = 0, y = 0, z = 0},
        rotation = parameters.rotation or 0,
        pivot    = parameters.pivot    or {x = 0.5, y = 0.5},
        scale    = parameters.scale    or {x = 1, y = 1},
    }
end
