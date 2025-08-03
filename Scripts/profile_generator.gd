extends Control
class_name CharacterProfileGenerator

enum Races{HUMAN, ELF, DWARF, HALFLING}

@export var shade_color: Color

@export_group("non-elven colors")
@export var skin_tone_map: GradientTexture2D
@export var hair_tone_map: GradientTexture2D

@export_group("elven colors")
@export var elven_skin_tone_map: GradientTexture2D
@export var elven_hair_tone_map: GradientTexture2D

var _race: Races = [Races.HUMAN, Races.ELF, Races.DWARF, Races.HALFLING].pick_random()

@onready var background: ColorRect = %Background
@onready var back_hair: TextureRect = %BackHair
@onready var body: TextureRect = %Body
@onready var mouth: TextureRect = %Mouth
@onready var eyes: TextureRect = %Eyes
@onready var front_hair: TextureRect = %FrontHair
@onready var nose: TextureRect = %Nose



func _ready() -> void:
	generate_character()


func generate_character() -> void:
	randomize()
	set_feature_texture(body, range(5).pick_random(), 0)
	set_feature_texture(eyes, range(5).pick_random(), 1)
	set_feature_texture(nose, range(5).pick_random(), 3)
	
	if _race == Races.DWARF:
		mouth.visible = false
	else:
		mouth.visible = true
		set_feature_texture(mouth, range(5).pick_random(), 2)
	
	var hair_index: int
	
	match _race:
		Races.ELF:
			hair_index = [5, 6, 8, 9, 10].pick_random()
		
		Races.DWARF:
			hair_index = [7, 11, 12].pick_random()
		
		_:
			hair_index = range(5).pick_random()
	
	set_feature_texture(front_hair, hair_index, 4)
	
	if hair_index >= 8:
		back_hair.visible = true
		set_feature_texture(back_hair, hair_index-8, 5)
	else:
		back_hair.visible = false
	
	if _race == Races.ELF:
		set_colors(elven_skin_tone_map, elven_hair_tone_map)
	else:
		set_colors(skin_tone_map, hair_tone_map)
	
	if _race == Races.HALFLING:
		back_hair.position.y = 64
		body.position.y = 64
		mouth.position.y = 64
		eyes.position.y = 64
		front_hair.position.y = 64
		nose.position.y = 64


func set_feature_texture(feature: TextureRect, x: int, y: int) -> void:
	feature.texture.region.position.x = x * 128
	feature.texture.region.position.y = y * 128
	feature.texture.region.size = Vector2.ONE * 128


func get_rando_color_from_map(texture: Texture2D) -> Color:
	var image := texture.get_image()
	return image.get_pixel(randi_range(0, image.get_size().x), randi_range(0, image.get_size().y))


func set_colors(skin_map: Texture2D, hair_map: Texture2D) -> void:
	var tones: Array[Color]
	
	tones.append(get_rando_color_from_map(skin_map))
	tones.append(tones[0].lerp(shade_color, 0.3))
	tones.append(tones[0].lerp(shade_color, 0.6))
	tones.append(Color.from_hsv(randf(), randf_range(.5, .95), randf_range(.5, 0.9)))
	tones.append(tones[3].lerp(shade_color, 0.3))
	tones.append(tones[3].lerp(shade_color, 0.6))
	tones.append(get_rando_color_from_map(hair_map))
	tones.append(tones[6].lerp(shade_color, 0.6))
	
	background.color = tones[3].inverted()
	
	material.set_shader_parameter("output_tones", tones)
