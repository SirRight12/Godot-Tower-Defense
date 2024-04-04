@tool
extends Node
class_name TowerRegistry
@onready var root = get_parent().get_parent()
@export var towers:Array[PackedScene]:
	set = set_array
var towers_placed: Dictionary = {}
func set_array(val):
	towers = val
	towers.resize(5)
func place_tower(idx,position):
	hide_all_tower_deny()
	var tower:Tower = towers[idx].instantiate()
	towers_placed[tower] = tower
	tower.set_position(position)
	root.add_child(tower)
	tower.hide_all()
	pass
func get_tower(idx):
	var tower = towers[idx]
	return tower
func hide_all_tower_deny():
	for x in towers_placed:
		var tower:Tower = towers_placed[x]
		if !tower: continue
		tower.hide_deny_place()
func show_all_tower_deny():
	for x in towers_placed:
		var tower:Tower = towers_placed[x]
		if !tower: continue
		tower.show_deny_place()
