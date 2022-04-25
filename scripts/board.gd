extends Node

export var row_count: int
export var col_count: int
export var x_start: float
export var y_start: float

const MAX_WIDTH = 576 # 9 X 64
const MAX_HEIGHT = 1024 # 16 X 64
const CELL_SIZE = 32.0
var ash_gray = Color("#CCD7C5") # could be a background
var misty_rose = Color("#EFD2CB") # background
var camel = Color("#C7A27C")
var mystic = Color("#D65780")
var dark_salmon = Color("#EE9480")

var cell_resource: Resource = preload("res://scenes/cell.tscn")
var all_cells: Array = []
var all_colors: PoolColorArray = [
	camel,
	mystic,
	dark_salmon,
]

func _ready() -> void:
	randomize()
	# VisualServer.set_default_clear_color(ash_gray)
	all_cells = make_board(row_count, col_count)
	spawn_cells(all_cells)
	
# func _process(delta: float) -> void:
# 	if all_cells[0].size() > 1 && all_cells[0][0] != null:
# 		all_cells[0][0].rotation += PI * delta

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
			var cell: Node = cell_resource.instance()
			var rand: int = int((rand_range(0, all_colors.size())))
			cell.color = all_colors[rand]
			cell.size =  CELL_SIZE
			var offset: float = calculate_offset()
			cell.transform.origin.x = x_start + (j * offset) + (CELL_SIZE / 2) # origin is moved to the center of the node
			cell.transform.origin.y = y_start + (i * offset) + (CELL_SIZE / 2) # origin is moved to the center of the node
			all_cells[i][j] = cell
			add_child(cell)

func calculate_offset() -> float:
	var offset: float = (MAX_WIDTH - 2 * x_start - CELL_SIZE * col_count) / col_count
	offset += CELL_SIZE
	return offset			
	
