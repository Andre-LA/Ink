local _assert = assert

return function  (parameters)
    local finalParameters = {
        useSliced = parameters.useSliced or false,
        imageColor = parameters.imageColor or {255,255,255,255},
    }
    if parameters.useSliced then
        _assert(parameters.images.up, "draw_image component: parameters.images.up is nil or false")
        _assert(parameters.images.left, "draw_image component: parameters.images.left is nil or false")
        _assert(parameters.images.right, "draw_image component: parameters.images.right is nil or false")
        _assert(parameters.images.down, "draw_image component: parameters.images.down is nil or false")
        _assert(parameters.images.leftup, "draw_image component: parameters.images.leftup is nil or false")
        _assert(parameters.images.upright, "draw_image component: parameters.images.upright is nil or false")
        _assert(parameters.images.downleft, "draw_image component: parameters.images.downleft is nil or false")
        _assert(parameters.images.rightdown, "draw_image component: parameters.images.rightdown is nil or false")
        _assert(parameters.images.center, "draw_image component: parameters.images.center is nil or false")

        finalParameters.images = parameters.images
    else
        _assert(parameters.image, "draw_image component: parameters.image is nil or false")
        finalParameters.image = parameters.image
    end
    return finalParameters
end
