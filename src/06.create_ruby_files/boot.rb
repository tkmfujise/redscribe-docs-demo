def greeting
  Godot.emit_signal :greeting, "Hello from Ruby"
end
