extends Node2D

export var thickness: float

var size: float
var color: Color
var draw_point: Vector2

onready var line: Node

func _ready() -> void:
  draw_point = Vector2(-size/2, -size/2)
  line = get_node("line")
  line.draw_start_point = draw_point
  line.draw_end_point = line.draw_start_point + Vector2(size, size)
  line.size = size
  line.color = color
  line.thickness = thickness

func _draw() -> void:
  draw_rect(Rect2(draw_point, Vector2(size, size)), color, false, thickness) # draw point of cell is moved to the upper left for the center of the node

func _to_string() -> String:
  return "x1: {0}, y1: {1}, size: {2}".format([self.x, self.y, size])
