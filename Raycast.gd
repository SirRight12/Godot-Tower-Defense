extends Camera3D
@export var console:Console
@export var tower_1:PackedScene
@export var tower_2:PackedScene
@export var tower_3:PackedScene
@export var tower_4:PackedScene
@export var tower_5:PackedScene

var place_holder_tower
var current_selected
var placeholder_visible = false
var is_on_path = false
var placeholder_position:Vector3
func get_placeholder(tower_selected:PackedScene):
	revoke_placeholder()
	place_holder_tower = tower_selected.instantiate()
	current_selected = tower_selected
	get_parent_node_3d().add_child(place_holder_tower)
	place_holder_tower.show_range()
	move_tower_to_mouse()
func revoke_placeholder():
	if !place_holder_tower: return
	current_selected = false
	is_on_path = false
	place_holder_tower.queue_free()
	place_holder_tower = false
func _unhandled_input(event):
	handle_cast(event)
	handle_move(event)
	handle_tower_select(event)
	handle_cancel(event)
func cast() -> Dictionary:
	var world = get_world_3d().direct_space_state
	var mouse = get_viewport().get_mouse_position()
	var from = project_ray_origin(mouse)
	var to = from + project_ray_normal(mouse) * 1000
	var query = PhysicsRayQueryParameters3D.create(from,to)
	var result = world.intersect_ray(query)
	return result
func handle_cast(event):
	if is_on_path: return
	if !place_holder_tower: return
	if event.is_action_released("pick"):
		console.log_clear()
		console.log_out(is_on_path)
		console.log_ln()
		console.log_out("init")
		console.log_ln()
		var tower = current_selected.instantiate()
		console.log_out("tower instantiated!")
		console.log_ln()
		tower.set_position(placeholder_position)		
		console.log_out("tower position set!")
		console.log_ln()
		revoke_placeholder()
		console.log_out("placeholder revoked!")
		console.log_ln()
		get_parent_node_3d().add_child(tower)
		console.log_out("added to scene!")
func handle_move(event):
	if !place_holder_tower: return
	if !event is InputEventMouseMotion: return
	move_tower_to_mouse()
func move_tower_to_mouse():
	var result = cast()
	if !result:
		is_on_path = true
		return
	console.log_clear()
	console.log_out(result['collider'].is_in_group("path"))	
	if result['collider'].is_in_group("path"):
		is_on_path = true
	else:
		is_on_path = false
	place_holder_tower.set_position(result['position'])
	placeholder_position = result['position']
func handle_tower_select(event):
	if event.is_action_released("select1"):
		get_placeholder(tower_1)
	elif event.is_action_released("select2"):
		get_placeholder(tower_2)
	elif event.is_action_released("select3"):
		get_placeholder(tower_3)
	elif event.is_action_released("select4"):
		get_placeholder(tower_4)
	elif event.is_action_released("select5"):
		get_placeholder(tower_5)
func handle_cancel(event):
	if !event.is_action_released("cancel"): return
	revoke_placeholder()
