import "graphics" for Canvas
import "./palette" for FG, BG
import "input" for Keyboard
import "math" for M

class Consequence {
  static new(message) { Consequence.new(message, 0) }
  construct new(message, time) {
    _message = message
    _time = time
  }

  message { _message }
  time { _time }

  execute(ctx) {
    var mins = ctx["minutes"] + time
    var hour = ctx["hour"]
    while (mins >= 60) {
      hour = (hour + 1) % 24
      mins = mins - 60
    }
    ctx["minutes"] = mins
    ctx["hour"] = hour
    ctx["result"] = message
  }
}


class Menu {

  static new(options) { Menu.new(options, null) }
  construct new(options, consequences) {
    _options = options
    _consequences = consequences
    _position = 0
  }

  update(ctx) {
    if (Keyboard["up"].justPressed) {
      _position = _position - 1
    } else if (Keyboard["down"].justPressed) {
      _position = _position + 1
    } else if (Keyboard["space"].justPressed) {
      if (_consequences) {
        _consequences[_position].execute(ctx)
      }
      return true
    }
    _position = (_position % _options.count).abs
    return false
  }

  draw(x, y) {
    var maxWidth = 0
    for (i in 0..._options.count) {
      if (i == _position) {
        Canvas.print(">", x + 0, y + i * 8, FG)
      }

      Canvas.print(_options[i], x + 8, y + i * 8, FG)
      maxWidth = M.max(maxWidth, _options[i].count)
    }
    maxWidth = maxWidth + 1

    Canvas.rect(x - 2, y - 2, 4 + maxWidth * 8, 4 + _options.count * 8, FG)

  }
}
