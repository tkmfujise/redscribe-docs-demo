@tool
extends Sprite2D
class_name Speaker

@export var speaker_name : Name : set = set_speaker
@export var face : Face : set = set_face

enum Name { Alice, WhiteRabbit }
enum Face { DEFAULT, FLUSTERD }


func set_speaker(val: int) -> void:
	frame_coords.y = val
	speaker_name = val


func set_face(val: int) -> void:
	frame_coords.x = val
	face = val
