extends Area2D

enum PipeType {
	Straight,
	DoubleBend,
	Intersection
}

@onready var shape: CollisionShape2D = $CollisionShape2D

enum Direction {
	North = 0,
	East = 1,
	South = 2,
	West = 3,
}

@export var type: PipeType;
@export var rotation_state: Direction = Direction.North;

var mouse_in: bool = false;

var frequency: int

signal fill_from_right(color: Color)
signal fill_from_left(color: Color)
signal fill_from_up(color: Color)
signal fill_from_down(color: Color)

var color_right: Color
var color_left: Color
var color_up: Color
var color_down: Color

func connected_edges() -> Array[Direction]:
	match type:
		PipeType.Straight:
			if rotation_state % 2 == 0:
				return [Direction.North, Direction.South]
			else:
				return [Direction.East, Direction.West]
		#PipeType.Bend:
		#	match rotation_state:
		#		Direction.North:
		#			return [Direction.North, Direction.West]
		#		Direction.East:
		#			return [Direction.East, Direction.North]
		#		Direction.South:
		#			return [Direction.South, Direction.East]
		#		Direction.West:
		#			return [Direction.West, Direction.South]
		_:
			return [Direction.North, Direction.East, Direction.South, Direction.West]
	
func coords(node: Node2D) -> Vector2i:
	return Vector2i(int(String(node.name)[4]), int(String(node.name)[5]))

func connected_pipes() -> Array:
	var my_coords: Vector2i = coords(self)
	var my_edges: Array[Direction] = connected_edges()
	var arr: Array = []
	for edge in my_edges:
		match edge:
			Direction.North:
				if my_coords.y == 1:
					continue
				var other: Node2D = get_parent().get_node("Pipe" + str(my_coords.x) + str(my_coords.y - 1))
				if Direction.South in other.connected_edges():
					arr.append([Direction.North, other])
			Direction.South:
				if my_coords.y == 5:
					continue
				var other: Node2D = get_parent().get_node("Pipe" + str(my_coords.x) + str(my_coords.y + 1))
				if Direction.North in other.connected_edges():
					arr.append([Direction.South, other])
			Direction.East:
				if my_coords.x == 5:
					continue
				var other: Node2D = get_parent().get_node("Pipe" + str(my_coords.x + 1) + str(my_coords.y))
				if Direction.West in other.connected_edges():
					arr.append([Direction.East, other])
			Direction.West:
				if my_coords.x == 1:
					continue
				var other: Node2D = get_parent().get_node("Pipe" + str(my_coords.x - 1) + str(my_coords.y))
				if Direction.East in other.connected_edges():
					arr.append([Direction.West, other])
		
	return arr

func _ready() -> void:
	frequency = self.get_parent().get_meta("flow_frequency", 3000)
	queue_redraw()
	fill_from_right.connect(on_fill_right)
	fill_from_left.connect(on_fill_left)
	fill_from_down.connect(on_fill_down)
	fill_from_up.connect(on_fill_up)

func get_real_color(dir1: Direction, dir2: Direction) -> Color:
	var arr: Array[Color] = [color_up, color_right, color_down, color_left]
	var c1: Color = arr[dir1]
	var c2: Color = arr[dir2]
	if c1 != Color.BLACK:
		return c1
	if c2 != Color.BLACK:
		return c2
	return Color.NAVAJO_WHITE

func on_fill_right(color: Color) -> void:
	if color_right == color:
		return
	color_right = color
	var cps: Array = connected_pipes()
	match self.type:
		PipeType.Intersection, PipeType.Straight:	
			for cp: Array in cps:
				if cp[0] == Direction.West:
					cp[1].fill_from_right.emit(color)
		PipeType.DoubleBend:
			for cp: Array in cps:
				if rotation_state % 2 != 0 and cp[0] == Direction.South:
					cp[1].fill_from_up.emit(color)
				if rotation_state % 2 == 0 and cp[0] == Direction.North:
					cp[1].fill_from_down.emit(color)
	
func on_fill_left(color: Color) -> void:
	if color_left == color:
		return
	color_left = color
	var cps: Array = connected_pipes()
	
	match self.type:
		PipeType.Intersection, PipeType.Straight:	
			for cp: Array in cps:
				if cp[0] == Direction.East:
					cp[1].fill_from_left.emit(color)
		PipeType.DoubleBend:
			for cp: Array in cps:
				if rotation_state % 2 == 0 and cp[0] == Direction.South:
					cp[1].fill_from_up.emit(color)
				if rotation_state % 2 != 0 and cp[0] == Direction.North:
					cp[1].fill_from_down.emit(color)
	
func on_fill_up(color: Color) -> void:
	if color_up == color:
		return
	color_up = color
	var cps: Array = connected_pipes()
	match self.type:
		PipeType.Intersection, PipeType.Straight:	
			for cp: Array in cps:
				if cp[0] == Direction.South:
					cp[1].fill_from_up.emit(color)
		PipeType.DoubleBend:
			for cp: Array in cps:
				if rotation_state % 2 != 0 and cp[0] == Direction.West:
					cp[1].fill_from_right.emit(color)
				if rotation_state % 2 == 0 and cp[0] == Direction.East:
					cp[1].fill_from_left.emit(color)
	
func on_fill_down(color: Color) -> void:
	if color_down == color:
		return
	color_down = color
	var cps: Array = connected_pipes()
	match self.type:
		PipeType.Intersection, PipeType.Straight:	
			for cp: Array in cps:
				if cp[0] == Direction.North:
					cp[1].fill_from_down.emit(color)
		PipeType.DoubleBend:
			for cp: Array in cps:
				if rotation_state % 2 == 0 and cp[0] == Direction.West:
					cp[1].fill_from_right.emit(color)
				if rotation_state % 2 != 0 and cp[0] == Direction.East:
					cp[1].fill_from_left.emit(color)

func _draw() -> void:
	var color_scalar: float = lerp(0., 0.4, abs((Time.get_ticks_msec() % frequency)/(frequency / 2.) - 1.0));
	var base_color: Color = Color.from_rgba8(70, 70, 70);	

	match type:
		PipeType.Straight:
			if self.rotation_state % 2 == 0:
				self.draw_rect(Rect2(35, 0, 30, 100), base_color)
				self.draw_rect(Rect2(40, 5, 20, 90), get_real_color(Direction.North, Direction.South).darkened(color_scalar))
			else:
				self.draw_rect(Rect2(0, 35, 100, 30), base_color)
				self.draw_rect(Rect2(Vector2(5, 40), Vector2(90, 20)), get_real_color(Direction.East, Direction.West).darkened(color_scalar))
		PipeType.DoubleBend:
			if self.rotation_state % 2 == 0:
				self.draw_rect(Rect2(35, 0, 30, 60), base_color)
				self.draw_rect(Rect2(35, 35, 65, 30), base_color)
				self.draw_rect(Rect2(40, 5, 20, 50), get_real_color(Direction.North, Direction.East).darkened(color_scalar))
				self.draw_rect(Rect2(40, 40, 60, 20), get_real_color(Direction.North, Direction.East).darkened(color_scalar))
				
				self.draw_rect(Rect2(0, 35, 65, 30), base_color)
				self.draw_rect(Rect2(35, 35, 30, 60), base_color)
				self.draw_rect(Rect2(5, 40, 55, 20), get_real_color(Direction.South, Direction.West).darkened(color_scalar))
				self.draw_rect(Rect2(40, 40, 20, 55), get_real_color(Direction.South, Direction.West).darkened(color_scalar))
			else:
				self.draw_rect(Rect2(35, 35, 65, 30), base_color)
				self.draw_rect(Rect2(35, 35, 30, 60), base_color)
				self.draw_rect(Rect2(40, 40, 60, 20), get_real_color(Direction.South, Direction.East).darkened(color_scalar))
				self.draw_rect(Rect2(40, 40, 20, 55), get_real_color(Direction.South, Direction.East).darkened(color_scalar))
				
				#print(name, color_left)
				self.draw_rect(Rect2(35, 0, 30, 60), base_color)
				self.draw_rect(Rect2(0, 35, 65, 30), base_color)
				self.draw_rect(Rect2(40, 5, 20, 50), get_real_color(Direction.North, Direction.West).darkened(color_scalar))
				self.draw_rect(Rect2(5, 40, 55, 20), get_real_color(Direction.North, Direction.West).darkened(color_scalar))
		PipeType.Intersection:
			if self.rotation_state % 2 == 0:
				self.draw_rect(Rect2(35, 0, 30, 100), base_color)
				self.draw_rect(Rect2(40, 5, 20, 90), get_real_color(Direction.North, Direction.South).darkened(color_scalar))
				self.draw_rect(Rect2(0, 35, 100, 30), base_color)
				self.draw_rect(Rect2(Vector2(5, 40), Vector2(90, 20)), get_real_color(Direction.East, Direction.West).darkened(color_scalar))
			else:
				self.draw_rect(Rect2(0, 35, 100, 30), base_color)
				self.draw_rect(Rect2(Vector2(5, 40), Vector2(90, 20)), get_real_color(Direction.East, Direction.West).darkened(color_scalar))
				self.draw_rect(Rect2(35, 0, 30, 100), base_color)
				self.draw_rect(Rect2(40, 5, 20, 90), get_real_color(Direction.North, Direction.South).darkened(color_scalar))
				
	
	color_left = Color.BLACK
	color_right = Color.BLACK
	color_up = Color.BLACK
	color_down = Color.BLACK
	
func _mouse_enter() -> void:
	mouse_in = true

func _mouse_exit() -> void:
	mouse_in = false
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and mouse_in:
		if event.button_index == MOUSE_BUTTON_LEFT:
			rotation_state += 1
			if rotation_state == 4:
				rotation_state = Direction.North

func _process(_delta: float) -> void:
	queue_redraw()
