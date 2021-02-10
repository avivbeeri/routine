import "graphics" for Canvas, Color
import "input" for Keyboard
import "./palette" for FG, BG
import "./sprites" for BED
import "./menu" for Menu, Consequence as CON


class Scene {
  update(ctx) {}
  draw() {}
  next { null }
}

class WakeUpScene is Scene {

  construct new() {
    _next = null
    _menu = Menu.new([
      "Get up",
      "Sleep in"
    ], [
      CON.new("You shuffle to the bathroom.", 10),
      CON.new("You sleep in, before shufflng to the bathroom", 60 + 10)
    ])
  }

  update(ctx) {
    _next = _menu.update(ctx)
  }

  draw() {
    BED.draw((Canvas.width - 32 * 3) / 2, Canvas.height / 2)
    _menu.draw(20, 20)
  }

  next { _next }
}

class ShowerScene is Scene {

  construct new() {
    _next = null
  }

  update(ctx) {
    if (Keyboard["space"].justPressed) {
      _next = true
    }
  }

  draw() {
  }

  next { _next }
}

