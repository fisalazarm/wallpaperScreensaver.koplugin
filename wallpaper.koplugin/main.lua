local WidgetContainer = require("ui/widget/container/widgetcontainer")
local util = require("util")
local logger = require("logger")
local _ = require("gettext")

-- === Configuración: cambia estas rutas si lo necesitas ===
-- En Boox, el protector de pantalla solo puede elegirse entre imágenes
-- que estén dentro de /Pictures, por eso guardamos ahí directamente.
local WALLPAPER_DIR   = "/storage/emulated/0/Pictures"
local WALLPAPER_FILE  = WALLPAPER_DIR .. "/cover.png"
local LAST_BOOK_MARK  = WALLPAPER_DIR .. "/.last_book"
-- ==========================================================

local Wallpaper = WidgetContainer:extend{
    name = "wallpaper",
    is_doc_only = true, -- solo se activa cuando hay un libro abierto
}

function Wallpaper:init()
    self.ui.menu:registerToMainMenu(self)
end

-- Se dispara cuando el lector terminó de cargar el documento
function Wallpaper:onReaderReady()
    self:updateWallpaper()
end

function Wallpaper:updateWallpaper()
    local file_path = self.ui.document and self.ui.document.file
    if not file_path then
        return
    end

    -- Leer qué libro fue el último procesado
    local last_book = nil
    local f = io.open(LAST_BOOK_MARK, "r")
    if f then
        last_book = f:read("*l")
        f:close()
    end

    -- Si es el mismo libro, no hacemos nada
    if last_book == file_path then
        logger.dbg("Wallpaper: same book, cover not regenerated")
        return
    end

    -- Asegurar que la carpeta exista
    util.makePath(WALLPAPER_DIR)

    -- Obtener la imagen de portada del documento actual
    local cover_bb = self.ui.document:getCoverPageImage()
    if not cover_bb then
        logger.warn("Wallpaper: this book has no cover available")
        return
    end

    local ok = cover_bb.writePNG and cover_bb:writePNG(WALLPAPER_FILE)
    cover_bb:free()

    if not ok then
        logger.warn("Wallpaper: could not write the cover image")
        return
    end

    -- Guardar registro del libro actual para la próxima comparación
    local wf = io.open(LAST_BOOK_MARK, "w")
    if wf then
        wf:write(file_path)
        wf:close()
    end

    logger.info("Wallpaper: cover updated for " .. file_path)
end

-- Entrada opcional en el menú para forzar la actualización manualmente
function Wallpaper:addToMainMenu(menu_items)
    menu_items.wallpaper_update_now = {
        text = _("Actualizar wallpaper con la portada actual"),
        callback = function()
            self:updateWallpaper()
        end,
    }
end

return Wallpaper
