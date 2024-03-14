extends PathEntity
class_name PathHealthEntity
@export var max_hp = 10
@export var is_enemy:bool = true
@onready var hp = max_hp
@onready var base = get_parent_node_3d().find_child("Base")
@export var resist: int
@onready var resistance:float = 1 - (resist / 100)
func _enter():
	base.take_damage(hp)
func take_damage(dmg):
	var damage = dmg * roundi(resistance)
	if damage <= 0:
		damage = 1
	hp -= damage
	if hp <= 0:
		queue_free()
