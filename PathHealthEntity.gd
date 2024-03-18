extends PathEntity
class_name PathHealthEntity
@export var max_hp = 10
@export var is_enemy:bool = true
@onready var hp = max_hp
@onready var base = get_parent_node_3d().find_child("Base")
@export var resist: int
@onready var resistance:float = 1 - (float(resist) / 100.0)
var dead = false
func _enter():
	base.take_damage(hp)
func take_damage(dmg):
	var damage = dmg * roundi(resistance)
	if damage <= 0:
		damage = 1
	hp -= damage
	var money_return = hp
	if hp <= 0 and !dead:
		queue_free()
		dead = true
		died.emit()
		if hp < 0:
			money_return += hp
		return money_return
	elif !dead:
		return money_return
