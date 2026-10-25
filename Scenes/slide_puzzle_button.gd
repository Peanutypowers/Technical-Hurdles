extends TextureButton


var slide_scene = preload("res://Scenes/board.tscn").instantiate()

func _on_pressed() -> void:
	get_tree().current_scene.hide()
	get_tree().root.add_child(slide_scene)
