extends PathEntity
class_name PathHealthEntity
@export var max_hp = 10
@export var is_enemy:bool = true
@onready var hp = max_hp
@onready var base = get_parent_node_3d().find_child("Base")
func _enter():
	base.take_damage(hp)
func _set_tag():
	if is_enemy:
		add_to_group("enemy")
	else:
		add_to_group("spawnable")
	pass
