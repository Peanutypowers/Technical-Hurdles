extends ColorRect

var bar_fall_check
var velocity = -25
var acceleration = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bar_fall_check:
		position.y += velocity
		velocity += acceleration


func _progress_bar_broken() -> void:
	bar_fall_check = true
