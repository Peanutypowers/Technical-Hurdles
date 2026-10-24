extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _cooper_image_2() -> void:
	$".".texture = load("res://assets/Cooper2.png")
func _cooper_image_3() -> void:
	$".".texture = load("res://assets/Cooper2b.png")
