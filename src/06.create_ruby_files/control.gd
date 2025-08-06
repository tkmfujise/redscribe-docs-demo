extends Control

@export var res : ReDScribe


func _ready() -> void:
	res.channel.connect(_subscribe)
	res.perform('greeting')


func _subscribe(key: StringName, payload: Variant) -> void:
	print_debug("[subscribe] ", key, ": ", payload)
