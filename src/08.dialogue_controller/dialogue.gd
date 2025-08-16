extends Control

@export var controller : ReDScribe

func _ready() -> void:
	controller.channel.connect(_handle)
	clear()


func speak(speaker: String, content: String, face: String) -> void:
	%Content.text = "(%s)\n%s" % [speaker, content]
	set_speaker(speaker)
	set_face(face)


func set_speaker(speaker: String) -> void:
	%Speaker.show()
	match speaker:
		'Alice':       %Speaker.speaker_name = Speaker.Name.Alice
		'WhiteRabbit': %Speaker.speaker_name = Speaker.Name.WhiteRabbit
		_: %Speaker.hide()


func set_face(face: String) -> void:
	match face:
		'flustered': %Speaker.face = Speaker.Face.FLUSTERD
		_: %Speaker.face = Speaker.Face.DEFAULT


func set_choices(choices: Dictionary = { 'Continue': null }) -> void:
	for child in %Buttons.get_children(): child.queue_free()
	for key in choices: add_choice(key, choices[key])


func add_choice(str: String, value: Variant) -> void:
	var btn = %ButtonTemplate.duplicate()
	%Buttons.add_child(btn)
	btn.text = str
	btn.pressed.connect(continue_dialogue.bind(value))
	btn.show()


func continue_dialogue(value) -> void:
	controller.perform('continue %s' % _value_for_rb(value))
	if controller.exception:
		printerr("controller: %s" % controller.exception)


func clear(all: bool = false) -> void:
	%Speaker.hide()
	%Content.text = ''
	set_choices()
	if all: %Buttons.hide()


func _value_for_rb(value: Variant) -> Variant:
	match typeof(value):
		TYPE_STRING_NAME: return ':%s' % value
		TYPE_STRING:      return '"%s"' % value
		TYPE_NIL:         return 'nil'
		_: return value


func _handle(key: StringName, payload: Variant) -> void:
	match key:
		&'says':
			speak(payload['name'], payload['content'], payload['face'])
			set_choices()
		&'asks':
			speak(payload['name'], payload['content'], payload['face'])
			set_choices(payload['choices'])
		&'background': print_debug("TODO [background] %s" % payload)
		&'finished': clear(true)
		_: print_debug('[%s] %s', [key, payload])
