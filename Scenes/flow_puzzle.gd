extends Node2D

signal game_won
var oneshot = false

func _process(_delta: float) -> void:
	if oneshot == false:
		if $"Flow Sink".satisfied:
			if $"Flow Sink3".satisfied:
				if $"Flow Sink2".satisfied:
					print("won")
					emit_signal("game_won", "flow")
					get_node("/root/Signal Manager").visible = true
					get_node("/root/FlowPuzzle").queue_free()
					oneshot = true
