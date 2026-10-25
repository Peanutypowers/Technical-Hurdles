extends TextureButton


var wave_scene = preload("res://Scenes/sine_wave_puzzle.tscn").instantiate()

func _on_pressed() -> void:
	get_tree().current_scene.hide()
	get_tree().root.add_child(wave_scene)
