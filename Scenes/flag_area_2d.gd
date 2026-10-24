extends Area2D

@export var scene:= "res://Scenes/platformer.tscn"

func _on_body_entered(body: Node2D) -> void:
	print("Yay")
	SceneManager.change_scene(scene)
