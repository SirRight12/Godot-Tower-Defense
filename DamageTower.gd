@icon("res://Tower.svg")
extends Tower
class_name DamageTower
@export var damage:int = 1
@export var attack_speed:float = 1
func _ready():
	pass
func get_tower_util(util_name:String) -> Node3D:
	return find_child(util_name)
func show_range():
	get_tower_util("Range").visible = true
func hide_range():
	get_tower_util("Range").visible = false
