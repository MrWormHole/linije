extends Node

export var width: int
export var height: int
export var x_start: int
export var y_start: int
export var offset: int

var possible_cells = [
	preload("res://scenes/black_cell.tscn"),
	preload("res://scenes/white_cell.tscn"),
]
var all_cells: Array = []

func _ready() -> void:
	randomize()

func make_board(rows: int, cols: int) -> Array:
	var arr: Array = []
	for i in range(rows):
		arr.append([])
		for j in range(cols):
			arr[i].append(null)
	return arr

func spawn_cells(rows: int, cols: int) -> void:
	for i in range(rows):
		for j in range(cols):
			var rand: int = floor(rand_range(0, possible_cells.size()))
			var cell = possible_cells[rand].instance()
			add_child(cell)
			cell.position = board_to_pixel(i, j)

func board_to_pixel(row: int, col: int) -> Vector2:
	var new_x: int = x_start + col * offset
	var new_y: int = y_start - row * offset
	return Vector2(new_x, new_y)

	