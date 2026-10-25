extends Control

@onready var goal: Control = $Container/Goal
@onready var boxplot: Control = $Container/WavePlot2
@onready var triplot: Control = $Container/WavePlot3
@onready var sinplot: Control = $Container/WavePlot4

signal game_won

func eql(v1: float, v2: float) -> bool:
	var v: float = abs(v1 / v2)
	return v < 1.2 and v > 0.8

func _process(_delta: float) -> void:
	var box: bool = eql(goal.box_amp, boxplot.amplitude_slider.value) and eql(goal.box_freq, boxplot.frequency_slider.value)
	if box:
		boxplot.foreground_color = Color.GREEN
	else:
		boxplot.foreground_color = Color.RED
	var tri: bool = eql(goal.tri_amp, triplot.amplitude_slider.value) and eql(goal.tri_freq, triplot.frequency_slider.value)
	if tri:
		triplot.foreground_color = Color.GREEN
	else:
		triplot.foreground_color = Color.SKY_BLUE
	var sin0: bool = eql(goal.sin_amp, sinplot.amplitude_slider.value) and eql(goal.sin_freq, sinplot.frequency_slider.value)
	if sin0:
		sinplot.foreground_color = Color.GREEN
	else:
		sinplot.foreground_color = Color.MEDIUM_PURPLE
		
	
	if box and tri and sin0:
		# win
		SceneManager.change_scene("res://Scenes/Platformer2.tscn")
		#print("win")
		#emit_signal("game_won", "wave")
		#get_node("/root/Signal Manager").visible = true
		#get_node("/root/Signal Manager").wave = true
		#get_node("/root/SineWavePuzzle").free()
