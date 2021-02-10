import "graphics" for ImageData
import "palette" for FG, BG

class Tilesheet {
  construct new(path) {
    _image = ImageData.loadFromFile(path)
  }

  draw(sx, sy, sw, sh, dx, dy) {
    draw(sx, sy, sw, sh, dx, dy, false)
  }

  draw (sx, sy, sw, sh, dx, dy, invert) {
    _image.transform({
      "srcX": sx, "srcY": sy,
      "srcW": sw, "srcH": sw
    }).draw(dx, dy)
  }

  getTile(sx, sy) {
    return getTile(sx, sy, 8, 8)
  }

  getTile(sx, sy, sw, sh) {
    return _image.transform({
      "srcX": sx, "srcY": sy,
      "srcW": sw, "srcH": sh,
      "scaleX": 3,
      "scaleY": 3,
      "mode": "MONO",
      "foreground": FG,
      "background": BG
    })
  }
}


