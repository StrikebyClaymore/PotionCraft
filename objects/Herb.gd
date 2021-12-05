extends "res://objects/PickableObject.gd"
class_name Herb

var in_pot: bool = false

var curves: Array = [preload("res://resources/curves/TestCurve.tres")]
var curve: Curve2D = curves[0]


func _ready() -> void:
	_inventorable = true
	pass

func _physics_process(delta: float) -> void:
	if _picked:
		global_position = get_global_mouse_position()

func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("pot"):
		in_pot = true
		z_index = 1

func _on_Area2D_area_exited(area: Area2D) -> void:
	if area.is_in_group("pot") and in_pot == true:
		get_tree().current_scene.character.add_path(curve)
		queue_free()
