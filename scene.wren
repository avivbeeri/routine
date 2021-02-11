import "graphics" for Canvas, Color
import "input" for Keyboard
import "./palette" for FG, BG
import "./sprites" for Sprites
import "./menu" for Menu, Consequence as CON

import "random" for Random
var RNG = Random.new()


class Scene {
  update(ctx) {}
  draw() {}
  valid(ctx) { true }
  clock { true }
  next { _next }
  next=(v) { _next = v }
}

class WakeUpScene is Scene {

  construct new(ctx) {
    _menu = Menu.new([
      "Get up",
      "Sleep longer"
    ], [
      CON.new("You shuffle to the bathroom.", 10),
      CON.new("You sleep in, before stumbling to the bathroom.", 60 + 10)
    ])
    ctx["hour"] = 7
    ctx["minutes"] = 0
  }

  update(ctx) {
    next = _menu.update(ctx)
  }

  draw() {
    Sprites.bed.draw((Canvas.width - 32 * 3) / 2, Canvas.height / 2)
    _menu.draw(20, 20)
  }
}

class ShowerScene is Scene {

  construct new(ctx) {
    _menu = Menu.new([
      "Shower",
      "Bath",
      "Don't wash"
    ], [
      CON.new("You shower quickly, it's cold outside.", 15),
      CON.new("You bathe for a while. Brief respite.", 60 + 10),
      CON.new("You don't wash, but no one will notice.", 5)
    ])
  }

  update(ctx) {
    next = _menu.update(ctx)
  }

  draw() {
    var w = 32
    var left = (Canvas.width - 32 * 3) / 2

    Sprites.toilet.draw(left, Canvas.height / 2)
    Sprites.bath.draw(left + 16 * 3, Canvas.height / 2)
    _menu.draw(20, 20)
  }
}

class BreakfastScene is Scene {

  construct new(ctx) {
    _menu = Menu.new([
      "Cereal",
      "Pancakes"
    ], [
      CON.new("Bowl, spoon, cereal, milk. Standard and reliable.", 10),
      CON.new("A small stack, sweet and sticky.", 45)
    ])
  }

  update(ctx) {
    next = _menu.update(ctx)
  }

  draw() {
    var w = 48
    var left = (Canvas.width - w * 3) / 2

    Sprites.chair.draw(left, Canvas.height / 2)
    Sprites.table.draw(left + 16 * 3, Canvas.height / 2)
    Sprites.cooker.draw(left + 32 * 3, Canvas.height / 2)
    _menu.draw(20, 20)
  }
}
class Chores1Scene is Scene {

  construct new(ctx) {
    _menu = Menu.new([
      "Clean dishes",
      "Leave dirty"
    ], [
      CON.new("Warm water and a clean slate.", 20),
      CON.new("A neat pile for later.", 5)
    ])
  }

  update(ctx) {
    next = _menu.update(ctx)
  }

  draw() {
    var w = 16
    var left = (Canvas.width - w * 3) / 2

    Sprites.sink.draw(left, Canvas.height / 2)
    Sprites.table.draw(left + 16 * 3, Canvas.height / 2)
    Sprites.dishes.draw(left + 16 * 3, Canvas.height / 2 - 4 * 3)
    _menu.draw(20, 20)
  }
}

class WorkScene is Scene {

  construct new(ctx) {
    // TODO random response
    _menu = Menu.new([
      "Work",
    ], [
      CON.new(RNG.float() < 0.5 ? "You work adequately." : "You achieve nothing.", 4 * 60),
    ])
    if (ctx["hour"] > 9) {
      ctx["hour"] = ctx["hour"] + 1
    } else {
      ctx["hour"] = 9
    }
    ctx["minutes"] = 0
  }

  update(ctx) {
    next = _menu.update(ctx)
  }

  draw() {
    var w = 32
    var left = (Canvas.width - w * 3) / 2

    Sprites.officechair.draw(left, Canvas.height / 2)
    Sprites.desk.draw(left + 16 * 3, Canvas.height / 2)
    _menu.draw(20, 20)
  }
}

class LunchScene is Scene {

  construct new(ctx) {
    // TODO random response
    _menu = Menu.new([
      "Simple lunch",
      "Warm lunch",
      "Skip lunch",
    ], [
      CON.new("Your usual lunch is fine.", 15),
      CON.new("Cosy in these times.", 25),
      CON.new("There are other things to do.", 5),
    ])

    if (ctx["hour"] > 12) {
      ctx["hour"] = ctx["hour"] + 1
    } else {
      ctx["hour"] = 12
    }
    ctx["minutes"] = 0
  }

  update(ctx) {
    next = _menu.update(ctx)
  }

  draw() {
    var w = 48
    var left = (Canvas.width - w * 3) / 2

    Sprites.chair.draw(left, Canvas.height / 2)
    Sprites.table.draw(left + 16 * 3, Canvas.height / 2)
    Sprites.cooker.draw(left + 32 * 3, Canvas.height / 2)
    _menu.draw(20, 20)
  }
}

class DinnerScene is Scene {
  construct new(ctx) {
    _menu = Menu.new([
      "Cook dinner",
      "Reheat",
      "Order dinner"
    ], [
      CON.new("Smells good, but takes so long.", 90),
      CON.new("Glad we made this yesterday.", 15),
      CON.new(RNG.float() < 0.7 ? "Delicious. Was this a good idea?" : "Not bad, but I feel unwell now.", 55),
    ])

    if (ctx["hour"] > 5) {
      ctx["hour"] = ctx["hour"] + 1
    } else {
      ctx["hour"] = 5
    }
    ctx["minutes"] = 0
  }

  update(ctx) {
    next = _menu.update(ctx)
  }

  draw() {
    var w = 48
    var left = (Canvas.width - w * 3) / 2

    Sprites.chair.draw(left, Canvas.height / 2)
    Sprites.table.draw(left + 16 * 3, Canvas.height / 2)
    Sprites.cooker.draw(left + 32 * 3, Canvas.height / 2)
    _menu.draw(20, 20)
  }
}

class EveningScene is Scene {
  construct new(ctx) {
    _menu = Menu.new([
      "TV",
      "Hobby",
      "Sleep",
    ], [
      CON.new("There's nothing else.", 2 * 60),
      CON.new("Might as well push on.", 1.5 * 60),
      CON.new("Maybe tomorrow will be better.", 15),
    ])
  }

  update(ctx) {
    next = _menu.update(ctx)
  }

  draw() {
    var w = 48
    var left = (Canvas.width - w * 3) / 2

    Sprites.bookshelf.draw(left, Canvas.height / 2)
    Sprites.fire.draw(left + 16 * 3, Canvas.height / 2 - 2 * 3)
    Sprites.bookshelf.draw(left + 32 * 3, Canvas.height / 2)
    _menu.draw(20, 20)
  }
}

class SleepScene is Scene {
  construct new(ctx) {
    _menu = Menu.new([
      "A new day",
      "Stop here",
    ], [
      CON.new("Your alarm wakes you. It is a new day."),
      CON.new("stop")
    ])
    _finish = false
  }

  update(ctx) {
    next = _menu.update(ctx)
    if (ctx["result"] == "stop") {
      next = false
      _finish = true
    }
  }

  printCenter(text, y) {
    var left = (Canvas.width - text.count * 8) / 2
    Canvas.print(text, left, y, FG)
  }

  draw() {
    var w = 48
    var h = Canvas.height / 2

    if (_finish) {
      printCenter("Thank you for", h - 12)
      printCenter("trying this", h - 4)
      printCenter("experience", h + 4)
      printCenter("The End.", h + 32)
    } else {
      _menu.draw((Canvas.width - 10 * 8) / 2, h - 8)
    }
  }

  clock { false }
}

class Begin is Scene {
  construct new(ctx) {
    _menu = Menu.new([
      "Begin",
    ], [
      CON.new("Your alarm wakes you. It is too loud."),
    ])
  }

  update(ctx) {
    next = _menu.update(ctx)
  }


  draw() {
    var w = 48
    var h = Canvas.height / 2
    _menu.draw((Canvas.width - 6 * 8) / 2, h - 4)
  }

  clock { false }
}
// This must come at the end
var Scenes = [
  WakeUpScene,
  ShowerScene,
  BreakfastScene,
  Chores1Scene,
  WorkScene,
  LunchScene,
  WorkScene,
  DinnerScene,
  EveningScene,
  SleepScene
]
