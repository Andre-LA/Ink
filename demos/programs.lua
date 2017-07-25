local Ink = require "ink"
local ink = Ink(false, "rect_transform",{
    -- ordem de processamento (exceto draw)
    "rect_transform",
    "button",
    "draw_image",
    "text",
    "rect_transform_viewer",
}, {
    -- ordem dos draws
    "draw_image",
    "button",
    "text",
    "rect_transform_viewer",
})
-- arquivo de demonstração (demo file)
local images = {
    leftup  = love.graphics.newImage "demos/image_test/9sliced/up_left.png",
    up      = love.graphics.newImage "demos/image_test/9sliced/up.png",
    upright = love.graphics.newImage "demos/image_test/9sliced/up_right.png",

    left    = love.graphics.newImage "demos/image_test/9sliced/left.png",
    center  = love.graphics.newImage "demos/image_test/9sliced/center.png",
    right   = love.graphics.newImage "demos/image_test/9sliced/right.png",

    downleft  = love.graphics.newImage "demos/image_test/9sliced/left_down.png",
    down      = love.graphics.newImage "demos/image_test/9sliced/down.png",
    rightdown = love.graphics.newImage "demos/image_test/9sliced/down_right.png",
}

local paleta = {
    vermelho = {222, 110, 104, 255},
    lima     = {157, 222, 104, 255},
    verde    = {104, 222, 110, 255},
    azul     = {104, 157, 222, 255},
    violeta  = {110, 104, 222, 255},
    rosa     = {222, 104, 157, 255}
}

local function add_all_necessary_systems ()
    ink:addSystem "gui/systems/rect_transform"
    ink:addSystem "gui/systems/draw_image"
    ink:addSystem "gui/systems/rect_transform_viewer"
    ink:addSystem "gui/systems/text"
    ink:addSystem "gui/systems/button"
end

local function abre_programa_1(painel_conteudo)
    local botao_ajuste_L = ink:createEntity ("ajustar L", painel_conteudo, "programa_1")
    local botao_ajuste_C = ink:createEntity ("ajustar C", painel_conteudo, "programa_1")
    local botao_ajuste_R = ink:createEntity ("ajustar R", painel_conteudo, "programa_1")
    local botao_ajuste_J = ink:createEntity ("ajustar J", painel_conteudo, "programa_1")

    local campo_texto = ink:createEntity("campo de texto", painel_conteudo, "programa_1")

    -- campo de texto
    ink:addComponent(campo_texto, "rect_transform", require ("gui/components/rect_transform")({
        anchors = {up = 0.7, down = 1, left = 1, right = 1},
        offset  = {up = 0, left = 40, right = 40, down = 40}
    }))
    ink:addComponent(campo_texto, "draw_image", require("gui/components/draw_image")({
        imageColor = {230,230,230,255},
        useSliced = true,
        images = images
    }))
    ink:addComponent(campo_texto, "text", require("gui/components/text")({
        editable = true,
        color = {20,20,20,255},
        --offsets = {x = 40, y = 40}
    }))
    ink:addComponent(campo_texto, "button", require("gui/components/button")({
        onClick = function(_, ent)
            ent.text.inEdit = true
        end,
        offClick = function(_, ent)
            ent.text.inEdit = false
        end
    }))

    -- botao de alinhamento esquerdo
    ink:addComponent(botao_ajuste_L, "rect_transform", require ("gui/components/rect_transform")({
        anchors = {left = 0.9, right = 0.25, up = 0.95, down = 0.15},
    }))
    ink:addComponent(botao_ajuste_L, "draw_image", require ("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.verde
    }))
    ink:addComponent(botao_ajuste_L, "button", require("gui/components/button")({
        onClick = function(_ink)
            _ink:getEntity(campo_texto).text.horizontalAlign = "left"
        end
    }))
    ink:addComponent(botao_ajuste_L, "text", require("gui/components/text")({
        text = "Alinhar à esquerda",
        horizontalAlign = "left",
        verticalAlign = "center",
    }))

    -- botao de alinhamento central
    ink:addComponent(botao_ajuste_C, "rect_transform", require ("gui/components/rect_transform")({
        anchors = {left = 0.7, right = 0.45, up = 0.95, down = 0.15},
    }))
    ink:addComponent(botao_ajuste_C, "draw_image", require ("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.verde
    }))
    ink:addComponent(botao_ajuste_C, "button", require("gui/components/button")({
        onClick = function(_ink)
            _ink:getEntity(campo_texto).text.horizontalAlign = "center"
        end
    }))
    ink:addComponent(botao_ajuste_C, "text", require("gui/components/text")({
        text = "Alinhar ao meio",
        horizontalAlign = "center",
        verticalAlign = "center",
    }))

    -- botao de alinhamento direito
    ink:addComponent(botao_ajuste_R, "rect_transform", require ("gui/components/rect_transform")({
        anchors = {left = 0.5, right = 0.65, up = 0.95, down = 0.15},
    }))
    ink:addComponent(botao_ajuste_R, "draw_image", require ("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.verde
    }))
    ink:addComponent(botao_ajuste_R, "button", require("gui/components/button")({
        onClick = function(_ink)
            _ink:getEntity(campo_texto).text.horizontalAlign = "right"
        end
    }))
    ink:addComponent(botao_ajuste_R, "text", require("gui/components/text")({
        text = "Alinhar à direita",
        horizontalAlign = "right",
        verticalAlign = "center",
    }))

    -- botao de alinhamento justificado
    ink:addComponent(botao_ajuste_J, "rect_transform", require ("gui/components/rect_transform")({
        anchors = {left = 0.3, right = 0.85, up = 0.95, down = 0.15},
    }))
    ink:addComponent(botao_ajuste_J, "draw_image", require ("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.verde
    }))
    ink:addComponent(botao_ajuste_J, "button", require("gui/components/button")({
        onClick = function(_ink)
            _ink:getEntity(campo_texto).text.horizontalAlign = "justify"
        end
    }))
    ink:addComponent(botao_ajuste_J, "text", require("gui/components/text")({
        text = "Alinhar com justificado",
        horizontalAlign = "justify",
        verticalAlign = "center",
    }))
end

local function fecha_programa_1()
    local entities = ink:getEntitiesIdsByKey("tag", "programa_1")
    for i=1,#entities do
        ink:removeEntity(entities[i])
    end
end

local function create_main_menu ()
    -- PAINEIS
    local menu_superior = ink:createEntity "menu superior"
    local painel_esquerdo = ink:createEntity "painel esquerdo"
    local painel_conteudo =ink:createEntity "painel de conteudo"

    -- adicionando os componentes do menu_superior
    ink:addComponent (menu_superior, "rect_transform", require ("gui/components/rect_transform")({
        anchors = {up = 1, left = 1, right = 1, down = 0},
        offset  = {up = 0, left = 0, right = 0, down = -30},
    }))

    ink:addComponent (menu_superior, "draw_image", require ("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.azul
    }))

    -- adicionando componentes do painel esquerdo
    ink:addComponent (painel_esquerdo, "rect_transform", require("gui/components/rect_transform")({
        anchors = {up = 1, left = 1, right = 0, down = 1},
        offset  = {up = 30, left = 0, down = 0, right = -120}
    }))
    ink:addComponent(painel_esquerdo, "draw_image", require("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.vermelho
    }))

    -- adicionando componentes do conteudo
    ink:addComponent(painel_conteudo, "rect_transform", require ("gui/components/rect_transform")({
        anchors = {up = 1, left = 1, right = 1, down = 1},
        offset  = {left = 120, up = 30, down = 0, right = 0}
    }))
    ink:addComponent(painel_conteudo, "draw_image", require("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.lima
    }))

    -- BOTOES DO PAINEL ESQUERDO
    local botao_programa_1 = ink:createEntity ("botao programa 1", painel_esquerdo)
    local botao_programa_2 = ink:createEntity("botao programa 2", painel_esquerdo)

    ink:addComponent(botao_programa_1, "rect_transform", require ("gui/components/rect_transform")({
        anchors = {left = 0.9, right = 0.9, up = 0.95, down = 0.1},
    }))
    ink:addComponent(botao_programa_1, "draw_image", require ("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.azul
    }))
    ink:addComponent(botao_programa_1, "button", require("gui/components/button")({
        onClick = function(_ink, ent)
            abre_programa_1(painel_conteudo, ent)
            ent.button.clickable = false
            _ink:getEntity(botao_programa_2).button.clickable = true
        end
    }))
    ink:addComponent(botao_programa_1, "text", require("gui/components/text")({
        text = "programa 1",
        horizontalAlign = "center",
        verticalAlign = "center"
    }))

    -- botao programa 2
    ink:addComponent(botao_programa_2, "rect_transform", require("gui/components/rect_transform")({
        anchors = {left = 0.9, right = 0.9, up = 0.85, down = 0.2}
    }))
    ink:addComponent(botao_programa_2, "draw_image", require ("gui/components/draw_image")({
        useSliced = true,
        images = images,
        imageColor = paleta.azul
    }))
    ink:addComponent(botao_programa_2, "button", require("gui/components/button")({
        onClick = function(_ink, ent)
            fecha_programa_1(painel_conteudo, ent)
            ent.button.clickable = false
            _ink:getEntity(botao_programa_1).button.clickable = true
        end
    }))
    ink:addComponent(botao_programa_2, "text", require("gui/components/text")({
        text = "programa 2",
        horizontalAlign = "center",
        verticalAlign = "center"
    }))

    if ink.devMode then
        ink:addComponent(menu_superior, "rect_transform_viewer", require("gui/components/rect_transform_viewer")({
            color = {255,255,255,255}
        }))
        ink:addComponent(painel_esquerdo, "rect_transform_viewer", require("gui/components/rect_transform_viewer")({}))
        ink:addComponent(painel_conteudo, "rect_transform_viewer", require("gui/components/rect_transform_viewer")({
            color={255,255,255,255}
        }))
    end
end

function love.load(arg)
    if arg and arg[#arg] == "-debug" then require("mobdebug").start() end

    add_all_necessary_systems()
    create_main_menu(images)
end

function love.update (dt)
    love.window.setTitle("Ink Demo: q/s (fps): [" .. love.timer.getFPS() .. "], qtd de entidades: " .. #ink.entities)

    ink:call("update", dt)
    ink:call("lateupdate", dt)
end

function love.draw ()
    ink:call("draw")
end

function love.keypressed (key, scancode, isrepeat)
    ink:call("keypressed", key, scancode, isrepeat)
end
function love.keyreleased (key)
    ink:call("keyreleased", key)
end
function love.directorydropped ()
    ink:call("directorydropped")
end
function love.filedropped (file)
    ink:call("filedropped", file)
end
function love.focus (focus)
    ink:call("focus", focus)
end
function love.lowmemory ()
    ink:call("lowmemory")
end
function love.mousefocus (focus)
    ink:call("mousefocus", focus)
end
function love.mousemoved (x, y, dx, dy, istouch)
    ink:call("mousemoved", x, y, dx, dy, istouch)
end
function love.mousepressed (x, y, button, istouch)
    ink:call("mousepressed", x, y, button, istouch)
end
function love.mousereleased (x, y, button, istouch)
    ink:call("mousereleased", x, y, button, istouch)
end
function love.quit()
    ink:call("quit")
end
function love.touchmoved (id, x, y, dx, dy, pressure)
    ink:call("touchmoved", id, x, y, dx, dy, pressure)
end
function love.touchpressed (id, x, y, dx, dy, pressure)
    ink:call("touchpressed", id, x, y, dx, dy, pressure)
end
function love.touchreleased (id, x, y, dx, dy, pressure)
    ink:call("touchreleased", id, x, y, dx, dy, pressure)
end
function love.visible(visible)
    ink:call("visible", visible)
end
function love.wheelmoved (x, y)
    ink:call("wheelmoved", x, y)
end
function love.resize(w, h)
    ink:call("resize", w, h)
end
function love.textinput (text)
    ink:call("textinput", text)
end
function love.textedited (text, start, length)
    ink:call("textedited", text, start, length)
end
function love.gamepadaxis (joystick, axis, value)
    ink:call("gamepadaxis", joystick, axis, value)
end
function love.gamepadpressed (joystick, button)
    ink:call("gamepadpressed", joystick, button)
end
function love.gamepadreleased (joystick, button)
    ink:call("gamepadreleased", joystick, button)
end
function love.joystickadded (joystick)
    ink:call("joystickadded", joystick)
end
function love.joystickaxis (joystick, axis, value)
    ink:call("joystickaxis", joystick, axis, value)
end
function love.joystickhat (joystick, hat, direction)
    ink:call("joystickhat", joystick, hat, direction)
end
function love.joystickpressed (joystick, button)
    ink:call("joystickpressed", joystick, button)
end
function love.joystickreleased (joystick, button)
    ink:call("joystickreleased", joystick, button)
end
function love.joystickremoved (joystick)
    ink:call("joystickremoved", joystick)
end
