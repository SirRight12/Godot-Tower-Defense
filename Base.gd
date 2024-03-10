extends Node
class_name Base
@export var max_hp = 1
@export var console:Console
@export var temp_shield:int = 0
@onready var current_temp_shield = temp_shield
@onready var hp = max_hp
func take_damage(dmg):
	var actual_damage = dmg
	if current_temp_shield > 0:
		actual_damage = dmg - current_temp_shield
		current_temp_shield -= dmg
	hp -= actual_damage
