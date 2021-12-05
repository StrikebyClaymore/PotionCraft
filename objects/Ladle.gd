extends "res://objects/PickableObject.gd"

var in_pot: bool = false
var pot_drop_position: Vector2 = Vector2(460, 440-96)


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if _picked:
		if in_pot and mode == RigidBody2D.MODE_RIGID:
			var impulse: Vector2 = Input.get_last_mouse_speed() * 0.1
			impulse.y *= 1.5
			#apply_central_impulse(impulse)
			apply_impulse(Vector2(0, -64), impulse)
		else:
			global_position = get_global_mouse_position()
			if rotation_degrees > 1.0:
				rotation_degrees -= 1.0
			elif rotation_degrees < -1.0:
				rotation_degrees += 1

func _pick() -> void:
	._pick()
	if in_pot:
		mode = RigidBody2D.MODE_RIGID

func _drop() -> void:
	._drop()
	if in_pot:
		global_position = pot_drop_position
		z_index = 1

func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("pot"):
		in_pot = true
		if not _picked:
			z_index = 1

func _on_Area2D_area_exited(area: Area2D) -> void:
	if area.is_in_group("pot"):
		in_pot = false
		z_index = 2
