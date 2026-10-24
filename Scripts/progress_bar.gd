extends TextureRect

var mouse_pos
var mouse_pressed = false
var progress_break_flag = 0
var progress_break_check = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var progress_collider = get_node("Area2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_pressed:
		mouse_pos = get_viewport().get_mouse_position().x
		size.x = mouse_pos - 486
	if size.x >= 920:
		size.x = 919
	
	if size.x >= 900 and !progress_break_check:
		progress_break_flag += 1
		print(progress_break_flag)
		progress_break_check = true
	
	if size.x < 600:
		progress_break_check = false


func _on_area_2d_update_progress_bar(button_pressed) -> void:
	mouse_pressed = button_pressed
	
