import "./tilesheet" for Tilesheet
var sheet = Tilesheet.new("./res/large.png")

var BED = sheet.getTile(96,128, 32, 16)
var BATH = sheet.getTile(208,160, 16, 16)
var TOILET = sheet.getTile(192,160, 16, 16)
var CHAIR = sheet.getTile(16,128, 16, 16)
var TABLE = sheet.getTile(32,128, 16, 16)
var COOKER = sheet.getTile(176,128, 16, 16)
var SINK = sheet.getTile(176,112, 16, 16)
var OFFICE_CHAIR = sheet.getTile(176,144, 16, 16)
var DESK = sheet.getTile(128,112, 16, 16)
var DISHES = sheet.getTransTile(240,176, 16, 16)
var BOOKSHELF = sheet.getTile(80,96, 16, 16)
var FIRE = sheet.getTile(224,272, 16, 16)

class Sprites {
  static bed { BED }
  static bath { BATH }
  static toilet { TOILET }
  static table { TABLE }
  static chair { CHAIR }
  static desk { DESK }
  static officechair { OFFICE_CHAIR }
  static cooker { COOKER }
  static sink { SINK }
  static dishes { DISHES }
  static bookshelf { BOOKSHELF }
  static fire { FIRE }
}
