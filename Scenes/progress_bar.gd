extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		print("test click")
		if IsMouseOverSprite():
			print("Clicked");
		
	
func IsMouseOverSprite():
	var rect = get_rect()
	if rect.has_point(get_global_mouse_position()):
		return true
	return false
