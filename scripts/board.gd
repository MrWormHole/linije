extends Node

export var row_count: int
export var col_count: int
export var x_start: int
export var y_start: int

const MAX_WIDTH = 576 # 9 X 64
const MAX_HEIGHT = 1024 # 16 X 64
const CELL_SIZE = 32.0
var ash_gray = Color("#CCD7C5") # could be a background
var misty_rose = Color("#EFD2CB") # background
var camel = Color("#C7A27C")
var mystic = Color("#D65780")
var dark_salmon = Color("#EE9480")

var cell_prefab = preload("res://scenes/cell.tscn")
var all_cells: Array = []
var all_colors: Array = [
	camel,
	mystic,
	dark_salmon,
]

func _ready() -> void:
	randomize()
	# VisualServer.set_default_clear_color(ash_gray)
	var cells = make_board(row_count, col_count)
	spawn_cells(cells)

func make_board(rows: int, cols: int) -> Array:
	var arr: Array = []
	for i in range(rows):
		arr.append([])
		for j in range(cols):
			arr[i].append(null)
	return arr

func spawn_cells(cells: Array) -> void:
	for i in range(cells.size()):
		for j in range(cells[i].size()):
			var cell = cell_prefab.instance()
			var rand: int = int((rand_range(0, all_colors.size())))
			cell.color = all_colors[rand]
			cell.width =  CELL_SIZE
			cell.height = CELL_SIZE
			var offset: float = calculate_offset()
			cell.x1 = float(x_start + (j * offset))
			cell.y1 = float(y_start + (i * offset)) 
			add_child(cell)

func calculate_offset() -> float:
	var offset: float = (MAX_WIDTH - 2 * x_start - CELL_SIZE * col_count) / col_count
	offset += CELL_SIZE
	return offset			
	
