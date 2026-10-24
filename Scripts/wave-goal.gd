extends Control

@onready var texture: TextureRect = $BoxContainer/TextureRect
@export var box_amp: float
@export var box_freq: float
@export var sin_amp: float
@export var sin_freq: float
@export var tri_amp: float
@export var tri_freq: float
@export var background_color: Color;
@export var foreground_color: Color;

var image: Image;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image = Image.create_empty(int(texture.size.x), int(texture.size.y), true, Image.FORMAT_RGBA8);
	regen_texture(0);
	
func regen_texture(_value: float) -> void:
	image.fill(background_color);
	if true:
		var y_off: int = int((self.image.get_size().y - box_amp) / 2);
		for x in range(self.image.get_size().x):
			var amp_bool: int = int(floor(x / box_freq)) % 2 == 0;
			if abs(floor(x / box_freq) - x/box_freq) < 0.001:
				for y in range(box_amp):
					image.set_pixel(x, y + y_off, Color.RED)
			image.set_pixel(x, round(box_amp * amp_bool) + y_off, Color.RED)
	
	if true:
		var y_off: int = int((self.image.get_size().y - tri_amp) / 2);
		for x in range(self.image.get_size().x):
			var progress: int = int(floor(x / tri_freq))
			if abs(floor(x / tri_freq) - x/tri_freq) < 0.001:
				for y in range(tri_amp):
					image.set_pixel(x, y + y_off, Color.SKY_BLUE)
			image.set_pixel(x, int((x/tri_freq - progress) * tri_amp + y_off), Color.SKY_BLUE);
		
	if true:
		var y_off: int = int((self.image.get_size().y - sin_amp) / 2);
		for x in range(self.image.get_size().x):
			image.set_pixel(x, int((sin(x / 200. * sin_freq) + 1.0)/2.0 * sin_amp) + y_off, Color.MEDIUM_PURPLE)	
				
	texture.texture = ImageTexture.create_from_image(image);
