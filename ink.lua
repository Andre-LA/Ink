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
local _pairs = pairs

function ink.new (devMode, transformComponent, executionOrder, drawOrder)
    local self = setmetatable({}, ink)

    self.devMode = devMode or false
    self.groups = {
        "default"
    }
    self.categories = {}
    self.entities = {}
    self.systems = {}
    self.executionOrder = executionOrder or {}
    self.drawOrder = drawOrder or {}
    self.velocity = 1
    self.lastEntityId = 0
    self.transformComponent = transformComponent

    return self
end

local function _updateSystemsEntities (entities, systems)
    for i=1, #systems do
        systems[i].entities = {}
        local sys_reqs = systems[i].requires

        for j=1, #entities do
            local check_list = 0
            for key in _pairs(entities[j]) do
                for k=1, #sys_reqs do
                    if key == sys_reqs[k] then
                        check_list = check_list + 1
                        break
                    end
                end
                if check_list == #sys_reqs then break end
            end
            if check_list == #sys_reqs then
                _table_insert(systems[i].entities, entities[j].id)
            end
        end
    end
end
-- local functions

local function _sortByZ (self, entities_ids)
    local entities = {}

    for i=1,#entities_ids do
        entities[#entities+1] = self:getEntity(entities_ids[i])
    end

    for i=1,#entities-1 do
        if entities[i][self.transformComponent].position.z > entities[i+1][self.transformComponent].position.z then
            entities[i+1], entities[i] = entities[i], entities[i+1]
            i = 0
        end
    end

    return entities
end

local function _sortToDraw (systems, draw_sort)
    local _findDrawOrder = function(system_name)
        for i=1,#draw_sort do
            if draw_sort[i] == system_name then
                return i
            end
        end
    end

    local sorted_systems = {_unpack(systems)}
    local quantity_of_systems = #sorted_systems

    if quantity_of_systems > 1 then
        for i=1,#sorted_systems do
            if i ~= quantity_of_systems then
                if _findDrawOrder(sorted_systems[i].name) > _findDrawOrder(sorted_systems[i+1].name) then
                    sorted_systems[i+1], sorted_systems[i] = sorted_systems[i], sorted_systems[i+1]
                    i = 0
                end
            end
        end
    end

    return sorted_systems
end

-- entity

function ink:createEntity (name, parent_id, tag)
    self.lastEntityId = self.lastEntityId + 1

    _table_insert(self.entities, {
        tag   = tag   or "default",
        name  = name  or "entity",
        id    = self.lastEntityId,
        parentId = parent_id or 0,
    })

    return self.lastEntityId
end

function ink:getEntity(entity_id)
    for i=1,#self.entities do
        if self.entities[i].id == entity_id then
            return self.entities[i]
        end
    end
end

function ink:getEntitiesIdsByKey(key, value)
    local entities_ids = {}
    for i=1,#self.entities do
        if self.entities[i][key] == value then
            entities_ids[#entities_ids+1] = self.entities[i].id
        end
    end
    return entities_ids
end

function ink:removeEntity (entity_id)
    for i=1,#self.entities do
        if self.entities[i].id == entity_id then
            _table_remove(self.entities, i)
            break
        end
    end

    for i=1,#self.systems do
        local system = self.systems[i]
        for j=1,#system.entities do
            if system.entities[j] == entity_id then
                _table_remove(system.entities, j)
                break
            end
        end
    end
end

-- components

function ink:addComponent (entity_id, component_name, component)
    local entity = self:getEntity(entity_id)
    entity[component_name] = component
    _updateSystemsEntities(self.entities, self.systems)
end

function ink:removeComponent (entity_id, component_name)
    local entity = self:getEntity(entity_id)
    entity[component_name] = nil
    _updateSystemsEntities(self.entities, self.systems)
end

-- systems

function ink:addSystem (url)
    local _findExecutionOrder = function (system_name)
        for i=1,#self.executionOrder do
            if system_name == self.executionOrder[i] then
                return i
            end
        end
    end

    -- get the system
    local system = _require (url).new(self)
    _assert(system, "system " .. url .. " is nil")

    -- discover the right index to insert this system based on executionOrder
    local systemOrder = _findExecutionOrder(system.name)
    _assert(systemOrder, "systemOrder of \"" .. system.name .. "\" is nil")

    local quantity_of_systems = #self.systems
    if quantity_of_systems >= 1 then
        for i=1,#self.systems do
            if _findExecutionOrder(self.systems[i].name) > systemOrder then
                _table_insert(self.systems, i, system)
                break
            elseif i == #self.systems then
                _table_insert(self.systems, system)
            end
        end
    else
        _table_insert(self.systems, system)
    end
end

function ink:getSystem (system_name)
    for i=1,#self.systems do
        if self.systems[i].name == system_name then
            return self.systems[i]
        end
    end
end

function ink:removeSystem (system_name)
    for i=1,#self.systems do
        local system = self.systems[i]
        if system.name == system_name then
            _table_remove(self.systems, i)
        end
    end
end

-- call a function of all systems

function ink:call (function_name, ...)
    local systems = {}

    for i=1,#self.systems do
        if self.systems[i][function_name] then
            systems[#systems+1] = self.systems[i]
        end
    end

    if function_name ~= "draw" then
        local i = 1
        while i <= #systems do
            local system = systems[i]
            local j = 1
            while j <= #system.entities do
                local entity = self:getEntity(system.entities[j])
                system[function_name](entity, ...)
                j=j+1
            end
            i=i+1
        end
    else
        local draw_systems = _sortToDraw(systems, self.drawOrder)

        for i=1,#draw_systems do
            local system = draw_systems[i]
            local entities = _sortByZ(self, system.entities)
            for j=1,#entities do
                system.draw(entities[j])
            end
        end
    end
end

return ink
