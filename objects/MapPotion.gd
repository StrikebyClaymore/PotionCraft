extends "res://objects/MapObject.gd"

enum TYPES { HEALING = 0, POISON = 1 }
export (TYPES) var type: int = TYPES.HEALING

func get_type_name() -> String:
	return TYPES.keys()[type]
