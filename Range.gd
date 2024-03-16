extends Area3D
class_name TowerRange
var areas = {}
@export var console:Console
signal enemy_enter()
func _enter_area(body:Node3D):
	var entity = get_entity(body)
	if not entity is PathHealthEntity: return
	if entity.speed < 0: return
	areas[str(body)] = body
func _exit_area(body):
	print(body)
	areas.erase(str(body))
	print(areas)
func _ready():
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
	return area.get_parent_node_3d()
