extends Node2D

signal progress_bar_broken

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _progress_bar_broken() -> void:
	progress_bar_broken.emit()


func _on_timer_timeout() -> void:
	print("yay!")


func _on_wave_puzzle_button_pressed() -> void:
	pass # Replace with function body.
