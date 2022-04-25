extends Node2D

var thickness: float
var size: float
var color: Color
var draw_start_point: Vector2
var draw_end_point: Vector2

onready var cell: Node

func _ready() -> void:
	cell = get_parent()
	print(cell.transform.origin)

func _draw() -> void:
	#if self.transform.origin.y < 50:
	# do a mask here for drawing so that some lines doesn't get out of the cell, use cell's origin position 	
	draw_line(draw_start_point, draw_end_point, color, thickness)

func _process(delta: float) -> void:
	self.rotation += PI * delta

func relative_to_global_point(local_point: Vector2) -> Vector2:
	# take the relative draw start point and get the global point, use cell's origin position
	return Vector2(0, 0)