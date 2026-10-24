extends Area2D

@export var near_pipe: Area2D
@export var needed_color: Color

var satisfied: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	var shape = $CollisionShape2D
	var frequency = get_parent().get_meta("flow_frequency", 1000)
	self.draw_rect(shape.shape.get_rect(), Color.from_rgba8(70, 70, 70));

	if satisfied:
		var color_scalar: float = lerp(0., 0.4, abs((Time.get_ticks_msec() % frequency)/(frequency / 2.) - 1.0));
		# Draw bg rect	# Draw fg flashing rect
		self.draw_rect(Rect2(shape.shape.get_rect().position + Vector2(10, 10), shape.shape.get_rect().size - Vector2(20, 20)), needed_color.darkened(color_scalar));
	else:
		draw_rect(Rect2(shape.shape.get_rect().position + Vector2(10, 10), shape.shape.get_rect().size - Vector2(20, 20)), needed_color.darkened(0.5))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	satisfied = near_pipe.color_left.to_rgba32() == needed_color.to_rgba32() and near_pipe.rotation_state % 2 != 0
	queue_redraw()
