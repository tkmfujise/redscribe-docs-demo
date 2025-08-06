extends Control
# A custome signal
signal some_signal(val: String)

func _ready() -> void:
	some_signal.connect(_on_some_signal)
	do_something()

func do_something() -> void:
	# ...
	some_signal.emit('foo')

func _on_some_signal(val: String) -> void:
	print_debug(val) # output 'foo'
