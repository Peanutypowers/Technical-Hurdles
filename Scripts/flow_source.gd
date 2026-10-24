extends Area2D

@onready var shape: CollisionShape2D = $CollisionShape2D

@export var near_node: Node2D
@export var direction_of_node: int
@export var pulse_color: Color

var frequency: int = 3000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frequency = self.get_parent().get_meta("flow_frequency", 3000)
	queue_redraw()

func _draw() -> void:
	var color_scalar: float = lerp(0., 0.4, abs((Time.get_ticks_msec() % frequency)/(frequency / 2.) - 1.0));
	# Draw bg rect
	self.draw_rect(shape.shape.get_rect(), Color.from_rgba8(70, 70, 70));
	# Draw fg flashing rect
	self.draw_rect(Rect2(shape.shape.get_rect().position + Vector2(10, 10), shape.shape.get_rect().size - Vector2(20, 20)), pulse_color.darkened(color_scalar));

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()
	if direction_of_node in near_node.connected_edges():
		if direction_of_node == 3:
			near_node.fill_from_left.emit(pulse_color)
		if direction_of_node == 1:
			near_node.fill_from_right.emit(pulse_color)
		if direction_of_node == 2:
			near_node.fill_from_down.emit(pulse_color)
