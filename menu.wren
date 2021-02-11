import "graphics" for Canvas
import "./palette" for FG, BG, MG
import "./keys" for Actions
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
    _maxWidth = 0
    for (i in 0..._options.count) {
      _maxWidth = M.max(_maxWidth, _options[i].count)
    }
    _maxWidth = _maxWidth + 1
  }

  update(ctx) {
    if (Actions.up.firing) {
      _position = _position - 1
    } else if (Actions.down.firing) {
      _position = _position + 1
    } else if (Actions.confirm.firing) {
      if (_consequences) {
        _consequences[_position].execute(ctx)
      }
      return true
    }
    _position = (_position % _options.count).abs
    return false
  }

  draw(x, y) {
    var maxWidth = _maxWidth
    x = (Canvas.width - 8 * _maxWidth) / 2
    for (i in 0..._options.count) {
      if (i == _position) {
        Canvas.print(">", x + 0, y + i * 8, FG)
        Canvas.print(_options[i], x + 8, y + i * 8, FG)
      } else {
        Canvas.print(_options[i], x + 8, y + i * 8, MG)
      }
    }

    for (i in 3..4) {
      Canvas.rect(x - i, y - i, i*2 + maxWidth * 8, i*2 + _options.count * 8, FG)
    }
  }
}
