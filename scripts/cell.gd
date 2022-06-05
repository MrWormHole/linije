extends Area2D

signal touch_occurred

export var thickness: float

var id: String
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
onready var board: Node

func _ready() -> void:
  draw_point = Vector2(-size/2, -size/2)
  current_state = State.EMPTY
  line = get_node("line")
  board = get_parent()
  connect("touch_occurred", board, "_on_cell_touch_occurred")
  
func _draw() -> void:
  draw_rect(Rect2(draw_point, Vector2(size, size)), color, false, thickness, true) # draw point of cell is moved to the upper left for the center of the node

# change_state is a function who changes every time someone clicks on the cell and tweens the line inside the cell then emits a signal to the board
func change_state() -> void:
  match current_state:
	  State.EMPTY:
		  current_state = State.LEFT_LINE
	  State.RIGHT_LINE:
		  current_state = State.LEFT_LINE
	  State.LEFT_LINE:
		  current_state = State.RIGHT_LINE
  emit_signal("touch_occurred", id)

func _to_string() -> String:
  return "x1: {0}, y1: {1}, size: {2}".format([self.x, self.y, size])
