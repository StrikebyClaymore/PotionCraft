extends Node2D

onready var rooms_node: Node2D = $GUI/RoomsNode
onready var character: Node2D = $GUI/RoomsNode/PotionCraftRoom/Map/Character
onready var inventory: Control = $GUI/PlayerInfo/Inventory
onready var potion_info: Control = $GUI/PotionCraft/PotionInfo
onready var identifying: Control = $GUI/PotionCraft/PotionInfo/Identifying

onready var potion_craft_room: Node2D = $GUI/RoomsNode/PotionCraftRoom
onready var trading_room: Node2D = $GUI/RoomsNode/TradingRoom

var current_node: Node2D
var pressed: bool = false
var selected_object: Node2D = null

const potion: PackedScene = preload("res://objects/Potion.tscn")


func _ready() -> void:
	rooms_node.remove_child(trading_room)
	current_node = potion_craft_room
	pass

func _unhandled_input(ev: InputEvent) -> void:
	if ev is InputEventMouseButton and ev.button_index == BUTTON_LEFT:
		pressed = ev.pressed
	if ev is InputEventMouseMotion:
		if not pressed:
			return
		
		if selected_object != null and is_instance_valid(selected_object) and selected_object.is_in_group("ladle") and selected_object.in_pot and selected_object.mode == RigidBody2D.MODE_RIGID:
			character.move()

func identify_potion(potion:Node2D) -> void:
	identifying.get_node("Label").text = potion.get_type_name()
	identifying.visible = true

func close_identifier() -> void:
	identifying.get_node("Label").text = ""
	identifying.visible = false

func _on_Accept_pressed() -> void:
	var p: RigidBody2D = potion.instance()
	p.position = Vector2(300, 100)
	current_node.add_child(p)
	close_identifier()
	rooms_node.get_node("PotionCraftRoom/Map").reset()

func _on_ToTrading_pressed() -> void:
	$GUI/PotionCraft.visible = false
	$GUI/RoomsNode/PotionCraftRoom.visible = false
	
	rooms_node.remove_child(potion_craft_room)
	rooms_node.add_child(trading_room)
	current_node = trading_room
	
	$GUI/RoomsNode/TradingRoom.visible = true
	$GUI/Trading.visible = true

func _on_ToCraft_pressed() -> void:
	$GUI/RoomsNode/TradingRoom.visible = false
	$GUI/Trading.visible = false
	
	rooms_node.remove_child(trading_room)
	rooms_node.add_child(potion_craft_room)
	current_node = potion_craft_room
	
	$GUI/PotionCraft.visible = true
	$GUI/RoomsNode/PotionCraftRoom.visible = true
