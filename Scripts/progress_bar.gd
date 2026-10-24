extends TextureRect

signal progress_bar_broken

var mouse_pos
var mouse_pressed = false
var progress_break_flag = 0
var progress_break_check = true
var button_load = false
var animation_check = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var progress_collider = get_node("Area2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button_load and size.x <= 512:
		size.x += randfn(1.0, 2.0)
	if size.x > 511:
		button_load = false
	if mouse_pressed:
		mouse_pos = get_viewport().get_mouse_position().x
		size.x = mouse_pos - 486
	if size.x >= 1020:
		size.x = 1019
	
	if size.x >= 900 and !progress_break_check:
		progress_break_flag += 1
		print(progress_break_flag)
		progress_break_check = true
	
	if size.x < 600:
		progress_break_check = false
	
	if progress_break_flag >= 3:
		progress_bar_broken.emit()
		if animation_check:
			$FractureAnimation.visible = true
			$FractureAnimation.play()
			animation_check = false
		


func _on_area_2d_update_progress_bar(button_pressed) -> void:
	mouse_pressed = button_pressed
	


func _on_start_button_pressed() -> void:
	button_load = true
