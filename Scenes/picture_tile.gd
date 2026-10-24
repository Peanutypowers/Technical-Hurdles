extends TextureButton

var num

# Update background image of title
func set_sprite(new_frame, size, tile_size):
	var sprite = $Sprite2D
	
	update_size(size, tile_size)
	
	sprite.set_hframes(size)
	sprite.set_vframes(size)
	sprite.set_frame(new_frame)

# Scale sprite to new tile size
func update_size(size, tile_size):
	var new_size = Vector2(tile_size, tile_size)
	set_size(new_size)
	
	var to_scale = size * (new_size/ $Sprite2D.texture.get_size())
	$Sprite.set_scale(to_scale)
