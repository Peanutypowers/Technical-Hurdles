extends TextureRect

signal progress_bar_broken
signal cooper_image_2
signal 	cooper_image_3
signal 	cooper_image_4
signal 	cooper_image_5

var mouse_pos
var mouse_pressed = false
var progress_break_flag = 0
var progress_break_check = true
var button_load = false
var animation_check = true
var completed_fracture = false
var timer_check = false
var start_timer = false
var new_timer = Timer.new()
var cooper_image_2_bool = false

var oneshot3 = false
var oneshot3_ = false
var oneshot2 = false
var oneshot4 = false
var oneshot4_ = false
var oneshot5 = false
var oneshot5_ = false
@export var dialogue_time = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var progress_collider = get_node("Area2D")
	add_child(new_timer)
	new_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	if oneshot3_ == false :
		cooper_image_3.emit()
		oneshot3_ = true
	if oneshot3_ == true && oneshot4_ == false :
		cooper_image_4.emit()
		oneshot4_ = true
	if oneshot4_ == true && oneshot5_ == false :
		cooper_image_5.emit()
		oneshot5_ = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button_load and size.x <= 512:
		size.x += randfn(1.0, 2.0)
	if size.x >= 500 && oneshot2 == false:
		cooper_image_2.emit()
		cooper_image_2_bool = true
		oneshot2 = true
	
	if cooper_image_2_bool && oneshot3 == false:
		new_timer.start(dialogue_time)
		cooper_image_2_bool = false
		oneshot3 = true
	
	if oneshot3 == true && oneshot4 == false:
		new_timer.start(dialogue_time)
		oneshot4 = true

	if oneshot4 == true && oneshot5 == false:
		new_timer.start(dialogue_time)
		oneshot5 = true
		
	
	if size.x > 511:
		button_load = false
	if mouse_pressed and animation_check:
		mouse_pos = get_viewport().get_mouse_position().x
		size.x = mouse_pos - 486
	if size.x >= 1018:
		size.x = 1017
	
	if size.x >= 900 and !progress_break_check:
		progress_break_flag += 1
		progress_break_check = true
	
	if size.x < 600:
		progress_break_check = false
	
	if progress_break_flag >= 3 and !completed_fracture:
		progress_bar_broken.emit()
		if animation_check:
			$FractureAnimation.visible = true
			$FractureAnimation.play()
			$"../CanvasLayer/Right/BlackBarFractureAnimation".visible = true
			$"../CanvasLayer/Right/BlackBarFractureAnimation".play()
			size.x = 1015
			animation_check = false
			completed_fracture = true
		


func _on_area_2d_update_progress_bar(button_pressed) -> void:
	mouse_pressed = button_pressed
	


func _on_start_button_pressed() -> void:
	button_load = true
