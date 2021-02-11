import "dome" for Window
import "graphics" for Canvas, Color
import "./palette" for FG, BG
import "math" for M
import "scene" for Scenes, Begin

var SCENE_TIMEOUT = 2 * 60

class Core {
  construct new() {}

  init() {
    var scale = 4
    Canvas.resize(160, 144)
    Window.title = "Routine"
    Window.resize(Canvas.width * scale, Canvas.height * scale)

    _stage = -1
    _scenes = Scenes

    // _fade = Canvas.height / 2
    // _fadeDir = -1
    // _waitTimer = SCENE_TIMEOUT

    _fade = 0
    _waitTimer = 0
    _fadeDir = 0

    _data = {
      "minutes": 0,
      "hour": 7,
      "result": "You awaken to an alarm clock. It is too loud."
    }

    // _currentScene = _scenes[_stage].new(_data)
    // _currentScene.valid(_data)
    _currentScene = Begin.new(_data)

    _time = generateTimeString()
  }

  lpad(n) {
    if (n < 10) {
      return "0%(n)"
    }
    return "%(n)"
  }

  update() {
    if (_waitTimer == 0) {
      _fade = M.mid(0, _fade + (_fadeDir), (Canvas.height / 2))
      if (_fade == (Canvas.height / 2)) {
        _waitTimer = SCENE_TIMEOUT
        var valid = false
        while (!valid) {
          _stage = (_stage + 1) % _scenes.count
          _currentScene = _scenes[_stage].new(_data)
          valid = _currentScene.valid(_data)
        }
      }
    } else {
      _waitTimer = _waitTimer - 1
    }

    if (_fade == 0) {
      _fadeDir = 0
    } else if (_fade == (Canvas.height / 2)) {
      _fadeDir = -1
    } else if (_fadeDir == -1) {
      _data["result"] = null
      _time = generateTimeString()
    }

    if (_fade == 0) {
      _currentScene.update(_data)
      if (_currentScene.next) {
        // Begin fadeout
        _fadeDir = 1
      }
    }
  }

  generateTimeString() {
    var hour = lpad(_data["hour"] % 24)
    var min = lpad(_data["minutes"] % 60)
    return "%(hour):%(min)"
  }

  draw(alpha) {
    Canvas.cls(BG)
    _currentScene.draw()
    if (_currentScene.clock) {
      Canvas.print(_time, 0, 0, FG)
    }

    if (_fade > 0) {
      var halfScreen = Canvas.height / 2
      var midTop = _fade
      var midBottom = Canvas.height - _fade
      Canvas.rectfill(0, 0, Canvas.width, _fade, BG)
      Canvas.rectfill(0, midBottom, Canvas.width, _fade, BG)

      if (_fade != halfScreen) {
        Canvas.line(0, midTop, Canvas.width, midTop, FG)
        Canvas.line(0, midBottom, Canvas.width, midBottom, FG)
      }
      if (_waitTimer > 0 && _data["result"]) {
        var maxWidth = (160 - 8) / 8
        var text = _data["result"]
        var words = text.split(" ")
        var lines = [""]
        for (word in words) {
          var line = lines[-1]
          if (line.count + word.count > maxWidth) {
            lines[-1] = line.trim()
            lines.add(word)
          } else {
            lines[-1] = "%(lines[-1]) %(word)"
          }
        }

        var y = (Canvas.height - 8 * lines.count) / 2
        for (line in lines) {
          Canvas.print(line, (Canvas.width - line.count * 8) / 2, y, FG)
          y = y + 8
        }
      }
    }
  }
}

var Game = Core.new()
