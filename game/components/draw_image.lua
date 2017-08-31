return function (parameters)
    return {
        image_source = parameters.image_source,
        color = parameters.color or {255, 255, 255, 255}
    }
end
