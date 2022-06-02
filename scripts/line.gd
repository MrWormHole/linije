extends Node2D

var thickness: float
var size: float
var color: Color
var draw_start_point: Vector2
var draw_end_point: Vector2
export var interpolation_seconds: float = 0.5

onready var cell: Node
onready var tween: Node

func _on_cell_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")
		
		if int(rad2deg(self.rotation)) % 90 != 0:
			return
		
		var current_rotation: float = self.rotation
		var next_rotation: float = self.rotation + deg2rad(90)
		tween.interpolate_property(self, "rotation", current_rotation, next_rotation, interpolation_seconds, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		print("Click ended")

func _ready() -> void:
	tween = get_node("tween")
	cell = get_parent()
	size = cell.size
	color = cell.color
	thickness = cell.thickness
	draw_start_point = Vector2(-size/2, -size/2)
	draw_end_point = draw_start_point + Vector2(size, size)	

func _draw() -> void:
	draw_line(draw_start_point, draw_end_point, color, thickness)

func relative_to_global_point(relative_point: Vector2) -> Vector2:
	# take the relative  point and get the global point, use cell's origin position
	return cell.transform.origin + relative_point

func global_to_relative_point(global_point: Vector2) -> Vector2:
	# take the global point and get the relative point, use cell's origin position
	return global_point - cell.transform.origin
