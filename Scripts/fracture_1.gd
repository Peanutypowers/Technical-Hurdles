extends Sprite2D

var velocity = -15
var acceleration = .5
var timer_check = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_timer = Timer.new()
	add_child(new_timer)
	new_timer.timeout.connect(_on_timer_timeout)
	new_timer.start(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_check:
		position.y += velocity
		velocity += acceleration
		position.x -= 10


func _on_timer_timeout() -> void:
	print("test1")
	timer_check = true
