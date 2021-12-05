tool
extends TextureRect

export (PackedScene) var content_tscn setget set_content

export var item_id: int = 0
export var count: int = 1


func set_content(value:PackedScene) -> void:
	content_tscn = value
	if content_tscn != null:
		var c = content_tscn.instance()
		if has_node("TextureRect") and c.has_node("Sprite"):
			get_node("TextureRect").texture = c.get_node("Sprite").texture
		c.queue_free()

func _ready() -> void:
	update_count()
	pass

func can_drop_data(position:Vector2, data:TextureRect) -> bool:
	return true

func drop_data(position:Vector2, data:TextureRect) -> void:
	#texture = data.texture
	#$TextureRect.texture = null
	pass

func get_drag_data(position:Vector2) -> Node:
	if $TextureRect.texture == null:
		return null
	var c = content_tscn.instance()
	get_tree().current_scene.current_node.add_child(c)
	c._pick()
	c.global_position = rect_global_position
	#$TextureRect.texture = null
	#$Panel.visible = false
	get_tree().current_scene.inventory.remove_item(self)
	return null

func update_count() -> void:
	$Count.text = str(count)
