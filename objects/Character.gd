extends KinematicBody2D

onready var path2d: Path2D = get_parent().get_node("Path2D")
var move_speed: float = 50.0
var patrol_points: Array = []
var patrol_index: int = 0
var velocity: = Vector2.ZERO

var paths: Array = []
var mix: bool = false
var target_recipe: Node2D


func _ready() -> void:
	pass

func move() -> void:
	if patrol_points.empty():
		return
	
	var target: Vector2 = patrol_points[patrol_index] + path2d.position
	if position.distance_to(target) < 1:
		patrol_index = patrol_index + 1
		if patrol_index > patrol_points.size() - 1:
			next_path()
			return
		target = patrol_points[patrol_index]
	velocity = (target - position).normalized() * move_speed
	velocity = move_and_slide(velocity)
	
	if target_recipe:
		var dist: float = position.distance_to(target_recipe.position)
		#print(dist)
		if dist <= 20.0:
			$ProgressBar.value = 20.0 - dist

func next_path() -> void:
	paths.pop_front()
	patrol_index = 0
	patrol_points.clear()
	path2d.curve = null
	if not paths.empty():
		path2d.curve = paths.front()
		patrol_points = path2d.curve.get_baked_points()
		path2d.position = position
	get_parent().update()

func add_path(curve:Curve2D) -> void:
	paths.append(curve)
	if patrol_points.empty():
		path2d.curve = curve
		patrol_points = path2d.curve.get_baked_points()
		path2d.position = position
	get_parent().update()

func reset() -> void:
	paths.clear()
	patrol_points.clear()
	path2d.curve = null
	get_parent().update()

func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("recipe"):
		target_recipe = area.get_parent()
		$ProgressBar.visible = true
		get_tree().current_scene.identify_potion(area.get_parent())

func _on_Area2D_area_exited(area: Area2D) -> void:
	if area.is_in_group("recipe"):
		target_recipe = null
		$ProgressBar.visible = false
		get_tree().current_scene.close_identifier()



