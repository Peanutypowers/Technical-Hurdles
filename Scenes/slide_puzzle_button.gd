extends TextureButton


var slide_scene = preload("res://Scenes/board.tscn").instantiate()

func _on_pressed() -> void:
	SceneManager.change_scene("res://Scenes/board.tscn")
