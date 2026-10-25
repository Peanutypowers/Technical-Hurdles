extends TextureButton


var wave_scene = preload("res://Scenes/sine_wave_puzzle.tscn").instantiate()

func _on_pressed() -> void:
	SceneManager.change_scene("res://Scenes/sine_wave_puzzle.tscn")
