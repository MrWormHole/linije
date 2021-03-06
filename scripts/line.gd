extends Node2D

export var interpolation_seconds: float = 0.5

var thickness: float
var size: float
var color: Color
var draw_start_point: Vector2
var draw_end_point: Vector2
var rotateable: bool

onready var cell: Node
onready var tween: Node

func _ready() -> void:
	tween = get_node("tween")
	cell = get_parent()
	size = cell.size
	color = cell.color
	thickness = cell.thickness
	draw_start_point = Vector2(-size/2, -size/2)
	draw_end_point = draw_start_point + Vector2(size, size)	
	rotateable = true

func _draw() -> void:
	if cell.current_state != cell.State.EMPTY:
		draw_line(draw_start_point, draw_end_point, color, thickness)

var can_be_pressed: bool = true

# _on_cell_input_event is a function that gets triggered every time a user clicks on the cell's area2D via touch/click
func _on_cell_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventScreenTouch && event.is_pressed():
		if !rotateable:
			return 
		rotateable = false

		if cell.current_state == cell.State.EMPTY:
			cell.change_state()
			update()
			rotateable = true
			return

		var current_rotation: float = self.rotation
		var next_rotation: float = self.rotation + deg2rad(90)
		tween.interpolate_property(self, "rotation", current_rotation, next_rotation, interpolation_seconds, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.start()
		cell.change_state()

func relative_to_global_point(relative_point: Vector2) -> Vector2:
	# take the relative  point and get the global point, use cell's origin position
	return cell.transform.origin + relative_point

func global_to_relative_point(global_point: Vector2) -> Vector2:
	# take the global point and get the relative point, use cell's origin position
	return global_point - cell.transform.origin

# _on_tween_completed is a function that sets line as rotateable after tween is finished
func _on_tween_completed(_object:Object, _key:NodePath):
	rotateable = true
