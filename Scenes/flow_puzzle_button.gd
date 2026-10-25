extends TextureButton


var flow_scene = preload("res://Scenes/flow-puzzle.tscn").instantiate()

func _on_pressed() -> void:
	get_tree().current_scene.hide()
	get_tree().root.add_child(flow_scene)
	#SceneManager.change_scene("res://Scenes/flow-puzzle.tscn")
