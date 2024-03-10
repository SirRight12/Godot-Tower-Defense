extends Area3D
var areas = {}
func _enter_area(body:Node3D):
	if !body.is_in_group("enemy"): return
	areas[str(body)] = body
	get_first_target()
	print(body)
func _exit_area(body):
	if !body.is_in_group("enemy"): return
	print(body)
	areas.erase(str(body))
	print(areas)
func _enter_tree():
	area_entered.connect(_enter_area)
	area_exited.connect(_exit_area)
func get_first_target():
	var places = []
	var dict = {}
	for x in areas:
		var entity = get_entity(areas[x])
		print(entity)
		places.append(entity.progress)
		
		places.sort()
		dict[entity.progress] = entity
	var target = dict[places[places.size() - 1]]
	return target
func get_entity(area):
	return area.get_parent_node_3d().get_parent_node_3d()
