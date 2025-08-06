extends Control

@onready var res := ReDScribe.new()

func _ready() -> void:
	get_window().content_scale_factor = 2.0
	res.method_missing.connect(_method_missing)
	%ReDScribeEditor.grab_focus()
	perform()


func perform() -> void:
	%RichTextLabel.text = ''
	res.perform(%ReDScribeEditor.text)


func add_circle() -> void:
	%RichTextLabel.add_text('◯')


func add_square() -> void:
	%RichTextLabel.add_text('■')


func _method_missing(method_name: String, _args: Array) -> void:
	match method_name:
		'circle': add_circle()
		'square': add_square()
		_: pass


func _on_re_d_scribe_editor_text_changed() -> void:
	perform()
