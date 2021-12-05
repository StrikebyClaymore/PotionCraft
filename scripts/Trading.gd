extends Control

const human_tscn: PackedScene = preload("res://objects/Human.tscn")


func _ready() -> void:
	next_human()
	pass

func _on_Sell_pressed() -> void:
	pass

func _on_Haggle_pressed() -> void:
	pass

func _on_End_pressed() -> void:
	pass

func _on_Area2D_body_entered(body: Node) -> void:
	pass

func next_human() -> void:
	var h: TextureRect = human_tscn.instance()
	$Humans.add_child(h)
	
	$Dialog.text = h.dialog
	print(h.rect_global_position)
