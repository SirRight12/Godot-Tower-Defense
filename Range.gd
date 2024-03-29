extends Area3D
class_name TowerRange
var areas = {}
var size:float:
	set = change_size
@onready var shape:CollisionShape3D = find_child("CollisionShape3D")
@onready var combiner:CSGCombiner3D = find_child("CSGCombiner3D")
signal enemy_enter()
func _enter_area(body:Node3D):
	var entity = get_entity(body)
	if not entity is PathHealthEntity: return
	if entity.speed < 0: return
	areas[str(body)] = body
func _exit_area(body):
	areas.erase(str(body))
func _ready():
	area_entered.connect(_enter_area)
	area_exited.connect(_exit_area)
func get_first_target():
	var places = []
	var dict = {}
	for x in areas:
		var entity = get_entity(areas[x])
		places.append(entity.progress)
		places.sort()
		dict[entity.progress] = entity
	var target = dict[places[places.size() - 1]]
	return target
func get_entity(area):
	return area.get_parent_node_3d()
func change_size(val):
	size = val
	shape.shape.radius = size
	combiner.scale = Vector3(size,size,size)
