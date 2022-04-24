extends Node2D

var color: Color
var x1: float
var y1: float
var width: float
var height: float

func _ready() -> void:
  pass

func _draw() -> void:
  draw_rect(Rect2(x1, y1, width, height), color, false, 3.0)

func _to_string() -> String:
  return "x1: {0}, y1: {1}, width: {2}, height: {3}".format([x1, y1, width, height])
