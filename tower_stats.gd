extends Control
@onready var tower_container = $Tower/Container/SV
@export var tower_dictionary:Dictionary
func set_up_for_tower(tower:Tower):
	var tower_name = tower.tower_name
	var viewport_scene = tower_dictionary[tower_name]
	remove_tower_stuff()
	var viewport_tower = viewport_scene.instantiate()
	tower_container.add_child(viewport_tower)
func remove_tower_stuff():
	var children = tower_container.get_children()
	for x in children.size():
		var child = children[x]
		child.queue_free()
