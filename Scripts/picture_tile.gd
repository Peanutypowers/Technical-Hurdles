extends TextureButton

var num
var row
var col

signal tile_pressed

func _ready():
	$Label.text = str(num + 1)




# Update background image of title
func set_sprite(new_frame, asize, tile_size):
	var sprite = $Sprite2D
	
	update_size(asize, tile_size)
	
	sprite.set_hframes(asize)
	sprite.set_vframes(asize)
	sprite.set_frame(new_frame)

# Scale sprite to new tile size
func update_size(asize, tile_size):
	var new_size = Vector2(tile_size, tile_size)
	set_size(new_size)
	
	var to_scale = asize * (new_size/ $Sprite2D.texture.get_size())
	$Sprite2D.set_scale(to_scale)

# Slide to new position
func slide_to(new_pos, dur):
	var tween = create_tween()
	tween.tween_property(self, "rect_position", new_pos, dur).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await tween.finished
	emit_signal("slide_completed")

func _on_slide_completed() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	emit_signal("tile_pressed", num, row, col)
	print("we pressed " + str(num))
