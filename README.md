# wallpaper.koplugin

[English](#english) | [Español](#español)

---

## English

Plugin for [KOReader](https://github.com/koreader/koreader) that automatically
saves the cover of the book you're reading as an image, so you can use it as
your device's screensaver / wallpaper.

Every time you open a book, the plugin exports its cover to:

```
/storage/emulated/0/Pictures/cover.png
```

If you reopen the same book that's already saved, it does nothing (to avoid
needlessly rewriting the file).

> **Note:** the `/Pictures` path was chosen with Android devices like the
> Onyx BOOX in mind, where the screensaver can only be picked from images
> located inside that folder. If you use a different device (Kobo, Kindle,
> etc.) you may want to change the path — see [Configuration](#configuration).

### Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/fisalazarm/wallpaperScreensaver.koplugin.git
   ```

2. Copy the whole `wallpaper.koplugin/` folder into KOReader's `plugins/`
   folder:
   - Android / BOOX: `/storage/emulated/0/koreader/plugins/`
   - Kobo: `.adds/koreader/plugins/`
   - Kindle: `koreader/plugins/`
3. Restart KOReader.
4. Open a book with a cover; `cover.png` will be generated at the configured
   path.

On Android, make sure KOReader has the "All files" permission (Settings →
Apps → KOReader → Permissions), otherwise the write will fail silently and
you'll see a `Wallpaper: no se pudo escribir la imagen de portada` warning in
the log.

### Usage

The plugin works on its own, no extra configuration needed. It also adds an
entry to the KOReader menu to manually force-update the current cover:

> Menu → *Update wallpaper with current cover*

#### Onyx BOOX

Boox doesn't watch folders automatically the way Kobo does. The first time,
manually select `cover.png` as the screensaver:

- Boox's **Screensaver** app, or
- File manager → long-press `cover.png` → *"use as screensaver"*.

Depending on the firmware, the system may or may not automatically refresh
the screensaver when the file's contents change without reselecting it.

### Configuration

The paths are at the top of `wallpaper.koplugin/main.lua`:

```lua
local WALLPAPER_DIR   = "/storage/emulated/0/Pictures"
local WALLPAPER_FILE  = WALLPAPER_DIR .. "/cover.png"
local LAST_BOOK_MARK  = WALLPAPER_DIR .. "/.last_book"
```

Change them according to your device or preference and restart KOReader.

### License

MIT — see [LICENSE](LICENSE).

---

## Español

Plugin para [KOReader](https://github.com/koreader/koreader) que guarda
automáticamente la portada del libro que estás leyendo como imagen, para
usarla como protector de pantalla / wallpaper del dispositivo.

Cada vez que abres un libro, el plugin exporta su portada a:

```
/storage/emulated/0/Pictures/cover.png
```

Si vuelves a abrir el mismo libro que ya está guardado, no hace nada (evita
reescribir el archivo innecesariamente).

> **Nota:** la ruta `/Pictures` se eligió pensando en dispositivos Android
> tipo Onyx BOOX, donde el protector de pantalla solo puede elegirse entre
> imágenes ubicadas dentro de esa carpeta. Si usas otro dispositivo (Kobo,
> Kindle, etc.) puede que quieras cambiar la ruta — ver [Configuración](#configuración).

### Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/fisalazarm/wallpaperScreensaver.koplugin.git
   ```

2. Copia la carpeta `wallpaper.koplugin/` completa dentro de la carpeta
   `plugins/` de KOReader:
   - Android / BOOX: `/storage/emulated/0/koreader/plugins/`
   - Kobo: `.adds/koreader/plugins/`
   - Kindle: `koreader/plugins/`
3. Reinicia KOReader.
4. Abre un libro con portada; se generará `cover.png` en la ruta configurada.

En Android, asegúrate de que KOReader tenga el permiso "Todos los archivos"
(Ajustes → Apps → KOReader → Permisos), o la escritura fallará
silenciosamente y verás un aviso `Wallpaper: no se pudo escribir la imagen
de portada` en el log.

### Uso

El plugin funciona solo, sin configuración adicional. También agrega una
entrada al menú de KOReader para forzar la actualización manual de la
portada actual:

> Menú → *Actualizar wallpaper con la portada actual*

#### Onyx BOOX

Boox no vigila carpetas automáticamente como sí lo hace Kobo. La primera
vez, selecciona manualmente `cover.png` como protector de pantalla:

- App **Screensaver** de Boox, o
- Gestor de archivos → mantén presionado `cover.png` → *"usar como
  protector de pantalla"*.

Dependiendo del firmware, el sistema puede o no refrescar automáticamente
el protector de pantalla cuando el contenido del archivo cambia sin
volver a seleccionarlo.

### Configuración

Las rutas están al inicio de `wallpaper.koplugin/main.lua`:

```lua
local WALLPAPER_DIR   = "/storage/emulated/0/Pictures"
local WALLPAPER_FILE  = WALLPAPER_DIR .. "/cover.png"
local LAST_BOOK_MARK  = WALLPAPER_DIR .. "/.last_book"
```

Cámbialas según tu dispositivo o preferencia y reinicia KOReader.

### Licencia

MIT — ver [LICENSE](LICENSE).
