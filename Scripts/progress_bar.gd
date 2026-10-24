extends TextureRect

var mouse_pos
var mouse_pressed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var progress_collider = get_node("Area2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_pressed:
		mouse_pos = get_viewport().get_mouse_position().x
		print(mouse_pos)
		size.x = mouse_pos - 657


func _on_area_2d_update_progress_bar(button_pressed) -> void:
	mouse_pressed = button_pressed
	
