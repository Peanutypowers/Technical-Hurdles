extends Node2D

signal game_won
var oneshot = false

func _process(_delta: float) -> void:
	if oneshot == false:
		if $"Flow Sink".satisfied:
			if $"Flow Sink3".satisfied:
				if $"Flow Sink2".satisfied:
					SceneManager.change_scene("res://Scenes/Platformer2.tscn")
