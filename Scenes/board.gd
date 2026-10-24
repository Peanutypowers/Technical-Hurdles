extends Control

@export var board_size: int = 4
@export var tile_size: int = 80
@export var tile_scene: PackedScene
@export var slide_dur: float = 0.15

var board = []
var tiles = []
var empty
var is_animating = false
var tiles_animating = 0

var move_count = 0
var background_texture = null

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
			tile.set_position(Vector2(c * tile_size, r * tile_size))
			tile.set_scale(Vector2(0.60, 0.60))
			tile.num = arr[r * board_size + c]
			tile.row = r
			tile.col = c
			tile.tile_pressed.connect(_on_tile_pressed)
			
			if(tile.num == 0):
				empty = tile.num
			
			add_child(tile)
			board[r].append(tile)

#func set_sprite(tile):
	#for i in (board_size * board_size):
		#if i == tile.num:
			#tile.texture_normal = preload("res://")

func move_tile():
	pass

func _on_tile_pressed(num, row, col):
	# Check if there is an empty (0) tile next to it
	
	var new_r
	var new_c
	if(num == 0):
		return
		
	# 0 is below
	if((row + 1 < board_size) and (board[row + 1][col].num == 0)):
		new_r = row + 1
		new_c = col
	# 0 is to right
	if((col + 1 < board_size) and (board[row][col + 1].num) == 0):
		new_r = row
		new_c = col + 1
	# 0 is above
	if((row - 1 < board_size) and row - 1 >= 0 and (board[row - 1][col].num) == 0):
		new_r = row - 1
		new_c = col
	# 0 is to left
	if((col - 1 < board_size) and col - 1 >= 0 and (board[row][col - 1].num) == 0):
		new_r = row
		new_c = col - 1
	
	# if next to 0, swap them
	if(new_r != null):
		# Swap them visually
		board[row][col].set_position(Vector2(new_c * tile_size, new_r * tile_size))
		board[new_r][new_c].set_position(Vector2(col * tile_size, row * tile_size))
		
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
		if i != 0:
			arr.append(i)
	arr.append(0) # have 0 be the last one
	for r in range(board_size):
		for c in range(board_size):
			if(board[r][c].num != 0 and board[r][c].num != arr[r * board_size + c]):
				return
	game_state = GAME_STATES.WON
	print("you won1!")

# temporary
func _ready():
	#tile_size = floor(get_size().x / board_size)
	#set_size(Vector2(tile_size * board_size, tile_size * board_size))
	#gen_board()
	create_board()
