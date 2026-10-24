extends Sprite2D

var velocity = -15
var acceleration = .75
var timer_check = false
var start_timer = false
var new_timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(new_timer)
	new_timer.timeout.connect(_on_timer_timeout)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start_timer:
		print("timer start")
		new_timer.start(1)
		start_timer = false
	if timer_check:
		position.y += velocity
		velocity += acceleration
		position.x -= 15


func _on_timer_timeout() -> void:
	timer_check = true
	$".".visible = true


func _progress_bar_broken() -> void:
	print("progress")
	start_timer = true
