extends Node2D

var size: float
var color: Color
var draw_point: Vector2
var current_state: int

enum State { 
  UNKNOWN,
  LOCKED, 
  UNLOCKED,
}

onready var label: Node

func _ready() -> void:
	draw_point = Vector2(-size/2, -size/2)
	current_state = State.UNKNOWN
	label = get_node("label")
	label.rect_position += Vector2(-size/2, -size/2)

func _draw() -> void:
	draw_circle_arc(draw_point, size/2, 0, 360, color)

func draw_circle_arc(center: Vector2, radius: float, angle_from: float, angle_to: float, fill_color: Color) -> void:
	var point_count: int = 360
	var points_arc: PoolVector2Array = PoolVector2Array([center])
	var colors: PoolColorArray = PoolColorArray([fill_color])

	for i in range(point_count + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / point_count - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors, PoolVector2Array(), null, null, true)

func _to_string() -> String:
	return "x1: {0}, y1: {1}, size: {2}".format([self.x, self.y, size])
