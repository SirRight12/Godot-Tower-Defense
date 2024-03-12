extends Camera3D
@export var console:Console
@export var filter_root:Control
@export var follow_mouse:ColorRect
@export var tower_1:PackedScene
@export var tower_2:PackedScene
@export var tower_3:PackedScene
@export var tower_4:PackedScene
@export var tower_5:PackedScene
@onready var filter:ColorRect = filter_root.find_child("Filter")
var can_place_color = Color(1.0,1.0,1.0,0.16)
var can_not_place_color = Color(1.0,0.0,0.08,0.16)
var place_holder_tower
var current_selected
var placeholder_visible = false
var is_on_path = false
var placeholder_position:Vector3
var placed_tower = false
var inspecting_tower = false
var inspected_tower
func set_filter(color:Color):
	filter.color = color
func show_filter():
	filter.visible = true
func hide_filter():
	filter.visible = false
func get_placeholder(tower_selected:PackedScene):
	revoke_placeholder()
	show_filter()
	place_holder_tower = tower_selected.instantiate()
	current_selected = tower_selected
	get_parent_node_3d().add_child(place_holder_tower)
	place_holder_tower.show_range()
	move_tower_to_mouse()
func revoke_placeholder():
	if !place_holder_tower: return
	hide_filter()
	current_selected = false
	is_on_path = false
	place_holder_tower.queue_free()
	place_holder_tower = false
func _unhandled_input(event):
	handle_cast(event)
	handle_move(event)
	handle_tower_select(event)
	handle_cancel(event)
	handle_tower_pick(event)
	handle_enemy_pick(event)
func cast(mask:int = 1) -> Dictionary:
	var world = get_world_3d().direct_space_state
	var mouse = get_viewport().get_mouse_position()
	var from = project_ray_origin(mouse)
	var to = from + project_ray_normal(mouse) * 1000
	var query = PhysicsRayQueryParameters3D.create(from,to)
	query.set_collide_with_areas(true)
	if mask:
		query.set_collision_mask(mask)
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
		placed_tower = true
		tower.hide_all()
func handle_move(event):
	if !place_holder_tower: return
	if !event is InputEventMouseMotion: return
	move_tower_to_mouse()
func move_tower_to_mouse():
	var result = cast()
	if !result:
		is_on_path = true
		return
	if result['collider'].is_in_group("path"):
		set_filter(can_not_place_color)
		is_on_path = true
	else:
		set_filter(can_place_color)
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
func handle_tower_pick(event):
	if placed_tower:
		placed_tower = false
		return
	if not event is InputEventMouseButton: return
	if place_holder_tower: 
		return
	if event.is_action_released("pick"):
		var result = cast(2)
		if !result:
			if inspected_tower:
				inspected_tower.hide_all()
				inspecting_tower = false
				inspected_tower = false
			return
		if result['collider'].name != "TowerCollider":
			return
		if inspected_tower:
			inspected_tower.hide_all()
		var parent = result['collider'].get_parent_node_3d()
		parent.show_all()
		inspecting_tower = true
		inspected_tower = parent


func handle_enemy_pick(event):
	if not event is InputEventMouseMotion:
		return
	var result = cast(8)
	if !result: 
		follow_mouse.visible = false
		return
	follow_mouse.visible = true
	follow_mouse.position = get_viewport().get_mouse_position() 
