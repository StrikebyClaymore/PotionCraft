extends Node2D

onready var character: Node2D = $Character
var start_point: Vector2 = Vector2(596/2, 492/2)
var current_start_point: Vector2

func _ready() -> void:
	reset()

func reset() -> void:
	character.position = start_point
	character.reset()
	$Path2D.position = start_point

func _draw() -> void:
	if character.paths.empty():
		return
	current_start_point = character.position
	for i in character.paths.size():
		var points: Array = character.paths[i].get_baked_points()
		for j in range(1, points.size()):
			draw_line(points[j-1]+current_start_point, points[j]+current_start_point, Color.black, 2.0)
		current_start_point += points.back()

