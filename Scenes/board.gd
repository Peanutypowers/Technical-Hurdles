extends Control

@export var board_size: int = 4
@export var tile_size: int = 80
@export var tile_scene: PackedScene
@export var slide_dur: float = 0.15

var board = []
var tiles = []
var max_size = 0

enum GAME_STATES {
	NOT_STARTED,
	STARTED,
	WON
}

var game_state = GAME_STATES.NOT_STARTED

signal game_started
signal game_won
signal moves_updated

func create_board():
	var arr = []
	for i in (board_size * board_size):
		arr.append(i)
	arr.shuffle()
	var value = 1
	for r in range(board_size):
		board.append([])
		for c in range(board_size):
			var tile = tile_scene.instantiate()
			tile.set_position(Vector2(540 + (c * tile_size * 2.75), 100 + (r * tile_size * 2.75)))
			tile.scale = Vector2(0.01 * tile_size, 0.01 * tile_size)
			tile.num = arr[r * board_size + c]
			tile.row = r
			tile.col = c
			tile.tile_pressed.connect(_on_tile_pressed)
			set_sprite(tile)

			add_child(tile)
			board[r].append(tile)

func set_sprite(tile):
	for i in (board_size * board_size):
		if i == tile.num:
			tile.texture_normal = load("res://assets/tiles/tile" + str(tile.num) + ".png")
			#tile.scale = Vector2(0.60, 0.60)
			#tile.rect_scale = Vector2(0.60, 0.60)

func move_tile():
	pass

func _on_tile_pressed(num, row, col):
	# Check if there is an empty (0) tile next to it
	
	var new_r
	var new_c
	if(num == max_size):
		return
		
	# 0 is below
	if((row + 1 < board_size) and (board[row + 1][col].num == max_size)):
		new_r = row + 1
		new_c = col
	# 0 is to right
	if((col + 1 < board_size) and (board[row][col + 1].num) == max_size):
		new_r = row
		new_c = col + 1
	# 0 is above
	if((row - 1 < board_size) and row - 1 >= 0 and (board[row - 1][col].num) == max_size):
		new_r = row - 1
		new_c = col
	# 0 is to left
	if((col - 1 < board_size) and col - 1 >= 0 and (board[row][col - 1].num) == max_size):
		new_r = row
		new_c = col - 1
	
	# if next to 0, swap them
	if(new_r != null):
		# Swap them visually
		var tween_1 = create_tween()
		tween_1.tween_property(board[row][col], "position", Vector2(540 + (new_c * tile_size * 2.75), 100 +(new_r * tile_size * 2.75)), slide_dur)
		#board[row][col].set_position(Vector2(new_c * tile_size * 2.75, new_r * tile_size * 2.75))
		#board[new_r][new_c].set_position(Vector2(col * tile_size * 2.75, row * tile_size * 2.75))
		var tween_2 = create_tween()
		tween_2.tween_property(board[new_r][new_c], "position", Vector2(540 + (col * tile_size * 2.75), 100 + (row * tile_size * 2.75)), slide_dur)
		
		# Swap them in board
		var temp = board[new_r][new_c]
		board[new_r][new_c] = board[row][col]
		board[row][col] = temp
		
		# Set the tile.row and tile.col to swap them
		board[new_r][new_c].row = new_r
		board[new_r][new_c].col = new_c
		
		board[row][col].row = row
		board[row][col].col = col
	else:
		# can't move
		return
	
	# Check for win condition
	# Check if board is in correct number order
	var arr = []
	for i in (board_size * board_size):
		arr.append(i)
	for r in range(board_size):
		for c in range(board_size):
			if(board[r][c].num != 0 and board[r][c].num != arr[r * board_size + c]):
				return
	game_state = GAME_STATES.WON
	
	SceneManager.change_scene("res://Scenes/Platformer2.tscn")
	
	get_node("/root/board").free()
	print("you won1!")

# temporary
func _ready():
	#tile_size = floor(get_size().x / board_size)
	#set_size(Vector2(tile_size * board_size, tile_size * board_size))
	#gen_board()
	max_size = (board_size * board_size) - 1
	create_board()


func _on_game_won() -> void:
	for r in range(board_size):
		for c in range(board_size):
			board[r][c].num = ' ' # i don't know if this works.
	pass # Replace with function body.
