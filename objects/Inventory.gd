extends Control
class_name Inventory

const slot_tscn: PackedScene = preload("res://objects/InventorySlot.tscn")
onready var container: GridContainer = $ScrollContainer/VBoxContainer/GridContainer


func _ready() -> void:
	pass

func add_item(item:RigidBody2D) -> void:
	for c in container.get_children():
		if c.item_id == item.item_id:
			c.count += 1
			c.update_count()
			return
	var s: TextureRect = slot_tscn.instance()
	s.content_tscn = load(item.get_filename())
	s.item_id = item.item_id
	container.add_child(s)

func remove_item(item:TextureRect):
	item.count -= 1
	item.update_count()
	if item.count == 0:
		container.remove_child(item)

