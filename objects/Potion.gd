extends "res://objects/PickableObject.gd"


func _ready() -> void:
	_inventorable = true
	pass

func _physics_process(delta: float) -> void:
	if _picked:
		global_position = get_global_mouse_position()
