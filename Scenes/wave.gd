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
	frequency_slider.changed.connect(regen_texture)
	amplitude_slider.changed.connect(regen_texture)
	
func regen_texture() -> void:
	var width: int = self.texture.get_width();
	var height: int = self.texture.get_height();
	
	var img: Image = Image.create(width, height, false, Image.FORMAT_BPTC_RGBA);
	img.fill(background_color);
	match WaveType:
		WaveType.Box:
			for x in range(width):
				#img.set_pixel(x, )
				pass
		WaveType.Triangle:
			pass
		WaveType.Sine:
			pass 
