extends RigidBody2D
class_name PickableObject


var _picked: bool = false
var _inventorable: bool = false

export (PickableItemTypes.TYPES) var item_id: int = 0


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _on_GameObject_input_event(viewport: Node, ev: InputEvent, shape_idx: int) -> void:
	if ev is InputEventMouseButton:
		if ev.is_pressed():
			_pick()

func _input(ev: InputEvent) -> void: # move to parent node for control picked items
	if ev is InputEventMouseButton and ev.button_index == BUTTON_LEFT:
		if _picked and !ev.pressed:
			_drop()

func _pick() -> void:
	mode = RigidBody2D.MODE_STATIC
	_picked = true
	get_tree().current_scene.selected_object = self

func _drop() -> void:
	_picked = false
	mode = RigidBody2D.MODE_RIGID
	apply_central_impulse(Input.get_last_mouse_speed())
	get_tree().current_scene.selected_object = null
	
	var inventory: Control = get_tree().current_scene.inventory
	if _inventorable and inventory.get_parent().get_rect().has_point(position):
		inventory.add_item(self)
		queue_free()

func _on_Area2D_area_entered(area: Area2D) -> void:
	pass

func _on_Area2D_area_exited(area: Area2D) -> void:
	pass


