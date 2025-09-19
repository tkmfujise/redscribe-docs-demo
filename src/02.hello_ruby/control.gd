extends Control

@onready var res := ReDScribe.new()


func _ready() -> void:
	res.method_missing.connect(_method_missing)
	res.perform("""
		Alice says: 'Hello Ruby! ❤'
	""")


func _method_missing(method_name: String, args: Array) -> void:
	print_debug('[method_missing] ', method_name, ': ', args)
