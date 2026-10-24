extends Area2D


func _on_area_entered(area: Area2D) -> void:
	SceneManager.change_scene("res://Scenes/platformer.tscn")
