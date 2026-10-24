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

var image: Image;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image = Image.create_empty(int(self.size.x), int(self.size.y), true, Image.FORMAT_RGBA8);
	frequency_slider.value_changed.connect(regen_texture)
	amplitude_slider.value_changed.connect(regen_texture)
	regen_texture(0);
	
func regen_texture(_value: float) -> void:
	var freq: float = self.frequency_slider.value
	var amp: float = self.amplitude_slider.value
	image.fill(background_color);
	var y_off: int = int((self.image.get_size().y - amp) / 2);
	match type:
		WaveType.Box:
			for x in range(self.image.get_size().x):
				var amp_bool: int = int(floor(x / freq)) % 2 == 0;
				if abs(floor(x / freq) - x/freq) < 0.001:
					for y in range(amp):
						image.set_pixel(x, y + y_off, foreground_color)
				image.set_pixel(x, round(amp * amp_bool) + y_off, foreground_color)
		WaveType.Triangle:
			for x in range(self.image.get_size().x):
				var progress: int = int(floor(x / freq))
				if abs(floor(x / freq) - x/freq) < 0.001:
					for y in range(amp):
						image.set_pixel(x, y + y_off, foreground_color)
				image.set_pixel(x, int((x/freq - progress) * amp + y_off), foreground_color);
		WaveType.Sine:
			for x in range(self.image.get_size().x):
				image.set_pixel(x, int(sin(x / 200. * freq) * amp) + y_off, foreground_color)
				
	self.texture = ImageTexture.create_from_image(image);
