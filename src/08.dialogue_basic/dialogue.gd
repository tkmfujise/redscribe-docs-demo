extends Control

@export var controller : ReDScribe


func _ready() -> void:
	controller.channel.connect(_handle)
	%Button.pressed.connect(continue_dialogue)
	clear()


func speak(speaker: String, content: String) -> void:
	%Content.text = "(%s)\n%s" % [speaker, content]


func continue_dialogue() -> void:
	controller.perform('continue')


func clear(all: bool = false) -> void:
	%Content.text = ''
	if all: %Button.hide()


func _handle(key: StringName, payload: Variant) -> void:
	match key:
		&'says': speak(payload['name'], payload['content'])
		&'finished': clear(true)
