extends Area2D

var progress_value
signal update_progress_bar(button_pressed)
var button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_progress_bar.emit(button_pressed)

	
func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		button_pressed = true
	if event.is_action_released("click"):
		button_pressed = false
