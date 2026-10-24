extends TextureButton

var num

# Update background image of title
func set_sprite(new_frame, size, tile_size):
	var sprite = $Sprite2D
	
	update_size(size, tile_size)
	
	sprite.set_hframes(size)
	sprite.set_vframes(size)
	sprite.set_frame(new_frame)
