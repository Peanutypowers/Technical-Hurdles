extends TextureButton


var flow_scene = preload("res://Scenes/flow-puzzle.tscn").instantiate()

func _on_pressed() -> void:
	SceneManager.change_scene("res://Scenes/flow-puzzle.tscn")
	
