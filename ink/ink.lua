local ink = {}
ink.__index = ink

setmetatable(ink, {
    __call = function (cls, ...)
        return cls.new(...)
    end
})

local _table_insert = table.insert
local _table_remove = table.remove
local _require = require
local _assert = assert
local _unpack = unpack

function ink.new (devMode, transformComponent, executionOrder, drawOrder)
    local self = setmetatable({}, ink)

    self.devMode = devMode or false
    self.groups = {
        "default",
    }
    self.entities = {}
    self.components = {}
    self.executionOrder = executionOrder or {}
    self.drawOrder = drawOrder or {}
    self.velocity = 1
    self.lastEntityId = 0
    self.transformComponent = transformComponent

    return self
end

local function _orderByZ (self, entities_ids)
    local entities = {}

    for i=1,#entities_ids do
        entities[#entities+1] = self:getEntity(entities_ids[i])
    end

    for i=1,#entities do
        if i ~= #entities then
            if entities[i][self.transformComponent].position.z > entities[i+1][self.transformComponent].position.z then
                entities[i+1], entities[i] = entities[i], entities[i+1]
                i = 1
            end
        end
    end

    return entities
end

local function _orderToDraw (components, draw_order)
    local _findDrawOrder = function(component_name)
        for i=1,#draw_order do
            if draw_order[i] == component_name then
                return i
            end
        end
    end

    local ordered_components = {_unpack(components)}
    local quantity_of_components = #ordered_components

    if quantity_of_components > 1 then
        for i=1,#ordered_components do
            if i ~= quantity_of_components then
                if _findDrawOrder(ordered_components[i].name) > _findDrawOrder(ordered_components[i+1].name) then
                    ordered_components[i+1], ordered_components[i] = ordered_components[i], ordered_components[i+1]
                    i = 1
                end
            end
        end
    end

    return ordered_components
end

function ink:getEntity(entity_id)
    for i=1,#self.entities do
        if self.entities[i].id == entity_id then
            return self.entities[i]
        end
    end
end

function ink:createEntity (name, parent, group, tag)
    self.lastEntityId = self.lastEntityId + 1

    _table_insert(self.entities, {
        tag   = tag   or "default",
        name  = name  or "entity",
        group = group or "default",
        id = self.lastEntityId,
        parentId = parent or 0,
    })

    return self.lastEntityId
end

function ink:removeEntity (entity_id)
    for i=1,#self.entities do
        if self.entities[i].id == entity_id then
            _table_remove(self.entities, i)
            break
        end
    end

    for i=1,#self.components do
        local component = self.components[i]
        for j=1,#component.entities do
            if component.entities[j] == entity_id then
                _table_remove(component.entities, j)
                break
            end
        end
    end
end

function ink:doComponentsFunction (function_name, ...)
    local components = {}

    for i=1,#self.components do
        if self.components[i][function_name] then
            components[#components+1] = self.components[i]
        end
    end

    if function_name ~= "draw" then
        local i = 1
        while i <= #components do
            local component = components[i]
            local j = 1
            while j <= #component.entities do
                local entity = self:getEntity(component.entities[j])
                component[function_name](self, entity, ...)
                j=j+1
            end
            i=i+1
        end
    else
        local draw_components = _orderToDraw(components, self.drawOrder)

        for i=1,#draw_components do
            local component = draw_components[i]
            local entities = _orderByZ(self, component.entities)
            for j=1,#entities do
                component.draw(self, entities[j])
            end
        end
    end
end

function ink:addComponent (url)
    local _findExecutionOrder = function (component_name)
        for i=1,#self.executionOrder do
            if component_name == self.executionOrder[i] then
                return i
            end
        end
    end

    -- get the component
    local component = _require (url).new()
    _assert(component, "component " .. url .. " is nil")

    -- discover the right index to insert this component based on executionOrder
    local componentOrder = _findExecutionOrder(component.name)
    _assert(componentOrder, "componentOrder of \"" .. component.name .. "\" is nil")

    local quantity_of_components = #self.components
    if quantity_of_components >= 1 then
        for i=1,#self.components do
            if _findExecutionOrder(self.components[i].name) > componentOrder then
                _table_insert(self.components, i, component)
                break
            elseif i == #self.components then
                _table_insert(self.components, component)
            end
        end
    else
        _table_insert(self.components, component)
    end
end

function ink:getComponent (component_name)
    for i=1,#self.components do
        if self.components[i].name == component_name then
            return self.components[i]
        end
    end
end

function ink:removeComponent (component_name)
    for i=1,#self.entities do
        local entity = self.entities[i]
        if entity[component_name] then
            entity[component_name] = nil
        end
    end
    for i=1,#self.components do
        local component = self.components[i]
        if component.name == component_name then
            _table_remove(self.components, i)
        end
    end
end

function ink:attachEntity (component_name, entity_id, parameters)
    for i=1,#self.components do
        local component = self.components[i]
        if component.name == component_name then
            _table_insert(component.entities, entity_id)
            local entity = self:getEntity(entity_id)
            entity[component_name] = component.applyParameters(parameters)
            break
        end
    end
end

function ink:detachEntity (component_name, entity_id)
    for i=1,#self.components do
        local component = self.components[i]
        if component.name == component_name then
            for j=1,#component.entities do
                if component.entities[j] == entity_id then
                    _table_remove(component.entities, j)
                    break
                end
            end
            break
        end
    end
end

return ink
