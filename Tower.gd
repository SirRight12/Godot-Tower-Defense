@icon("res://Tower.svg")
extends Node3D
class_name Tower
@export var tower_range:float = 1.0
@export var cost:int = 100
@export var upgrades:Array[Upgrade]
@onready var utils = find_child("TowerUtils")
func _ready():
	add_to_group("tower")
func get_tower_util(util_name:String) -> Node3D:
	return utils.find_child(util_name)
func show_range():
	get_tower_util("Range").visible = true
func hide_range():
	get_tower_util("Range").visible = false
func show_deny_place():
	get_tower_util("DenyPlace").visible = true
func hide_deny_place():
	get_tower_util("DenyPlace").visible = false
func show_all():
	show_range()
	show_deny_place()
func hide_all():
	hide_range()
	hide_deny_place()
