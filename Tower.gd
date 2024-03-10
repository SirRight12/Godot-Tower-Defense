@icon("res://Tower.svg")
extends Node3D
class_name Tower
@export var range:float = 1.0
@export var cost:int = 100
@export var upgrades:Array[Upgrade]

func get_tower_util(util_name:String) -> Node3D:
	return find_child(util_name)
func show_range():
	get_tower_util("Range").visible = true
func hide_range():
	get_tower_util("Range").visible = false
