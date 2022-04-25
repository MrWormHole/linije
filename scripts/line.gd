extends Node2D

var thickness: float
var size: float
var color: Color
var draw_start_point: Vector2
var draw_end_point: Vector2

onready var cell: Node

### THESE ARE FOR DEBUGGING PURPOSE ONLY
var timer = 0
var wait_time = 2
var switch = false
### THESE ARE FOR DEBUGGING PURPOSE ONLY

func _ready() -> void:
	cell = get_parent()
	size = cell.size
	color = cell.color
	thickness = cell.thickness
	draw_start_point = Vector2(-size/2, -size/2)
	draw_end_point = draw_start_point + Vector2(size, size)	

func _draw() -> void:
	draw_line(draw_start_point, draw_end_point, color, thickness)


func _process(delta: float) -> void:
	timer+=delta
	if timer>wait_time:
		switch = true
		timer = 0

	if !switch:
		return	

	self.rotation += PI * delta
	draw_start_point = draw_start_point.rotated(PI * delta)
	draw_end_point = draw_end_point.rotated(PI * delta)

	if relative_to_global_point(draw_start_point).y < cell.transform.origin.y - size / 2 || relative_to_global_point(draw_start_point).y > cell.transform.origin.y + size / 2:
		draw_start_point.y = global_to_relative_point(cell.transform.origin).y
	if relative_to_global_point(draw_start_point).x < cell.transform.origin.x - size / 2 || relative_to_global_point(draw_start_point).x > cell.transform.origin.x + size / 2:
		draw_start_point.x = global_to_relative_point(cell.transform.origin).x

	if relative_to_global_point(draw_end_point).y < cell.transform.origin.y - size / 2 || relative_to_global_point(draw_end_point).y > cell.transform.origin.y + size / 2:
		draw_end_point.y = global_to_relative_point(cell.transform.origin).y
	if relative_to_global_point(draw_end_point).x < cell.transform.origin.x - size / 2 || relative_to_global_point(draw_end_point).x > cell.transform.origin.x + size / 2:
		draw_end_point.x = global_to_relative_point(cell.transform.origin).x

	
	update()
	switch = false

func relative_to_global_point(relative_point: Vector2) -> Vector2:
	# take the relative  point and get the global point, use cell's origin position
	return cell.transform.origin + relative_point

func global_to_relative_point(global_point: Vector2) -> Vector2:
	# take the global point and get the relative point, use cell's origin position
	return global_point - cell.transform.origin
