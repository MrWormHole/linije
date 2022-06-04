extends Area2D

export var thickness: float

var size: float
var color: Color
var draw_point: Vector2
var current_state: int

enum State { 
  EMPTY,
  LEFT_LINE, 
  RIGHT_LINE,
}

onready var line: Node

func _ready() -> void:
  draw_point = Vector2(-size/2, -size/2)
  current_state = State.EMPTY
  line = get_node("line")
  
func _draw() -> void:
  draw_rect(Rect2(draw_point, Vector2(size, size)), color, false, thickness, true) # draw point of cell is moved to the upper left for the center of the node

# change_state is a function who changes every time someone clicks on the cell and tweens the line inside the cell
func change_state() -> void:
  if current_state == State.EMPTY:
    current_state = State.LEFT_LINE
  elif current_state == State.RIGHT_LINE:
    current_state = State.LEFT_LINE
  elif current_state == State.LEFT_LINE:
    current_state = State.RIGHT_LINE

func _to_string() -> String:
  return "x1: {0}, y1: {1}, size: {2}".format([self.x, self.y, size])
