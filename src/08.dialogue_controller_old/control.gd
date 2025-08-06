extends Control

@export var scenario : ReDScribe

func _ready() -> void:
	scenario.channel.connect(_handle)
	clear()


func speek(speaker: String, content: String) -> void:
	%Label.text = speaker_icon(speaker)
	%RichTextLabel.text = "(%s)\n%s" % [speaker, content]


func speaker_icon(speaker: String) -> String:
	match speaker:
		'Alice':       return '👩🏼‍🦰'
		'WhiteRabbit': return '🐰'
		_: return ''


func scenario_continue() -> void:
	scenario.perform('Scene.current.continue')


func clear(all: bool = false) -> void:
	%Label.text = ''
	%RichTextLabel.text = ''
	if all: %Button.hide()


func _handle(key: StringName, params: Variant) -> void:
	match key:
		&'says': speek(params['name'], params['content'])
		&'finished': clear(true)
		_: print_debug('[%s] %s', [key, params])


func _on_button_pressed() -> void:
	scenario_continue()
