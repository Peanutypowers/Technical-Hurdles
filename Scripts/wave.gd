extends TextureRect

@export var frequency_slider: VSlider
@export var amplitude_slider: VSlider

enum WaveType {
	Box,
	Triangle,
	Sine,
};

@export var type: WaveType;
@export var background_color: Color;
@export var foreground_color: Color;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frequency_slider.value_changed.connect(regen_texture)
	amplitude_slider.value_changed.connect(regen_texture)
	
func regen_texture(value: float) -> void:
	var width: int = self.texture.get_width();
	var height: int = self.texture.get_height();
	
	var img: Image = Image.create(width, height, false, Image.FORMAT_BPTC_RGBA);
	img.fill(background_color);
	match WaveType:
		WaveType.Box:
			for x in range(width):
				var amp: int = floor(x / value) % 2 == 0;
				img.set_pixel(x, round(amp * value), foreground_color);
		WaveType.Triangle:
			pass
		WaveType.Sine:
			pass 
			
	print("Regenerated!")
	self.texture = ImageTexture.create_from_image(img);
