extends Area2D

signal pressed()
var is_pressed: bool = false


func _on_Button2D_input_event(viewport: Node, ev: InputEvent, shape_idx: int) -> void:
	if ev is InputEventMouseButton:
		is_pressed = ev.pressed
		if is_pressed:
			emit_signal("pressed")
