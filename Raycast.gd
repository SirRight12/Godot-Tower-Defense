extends Camera3D
@export var filter_root:Control
@export var follow_mouse:ColorRect
@export var console:Console
@export var tower_stats:Control
@onready var follow_percent = follow_mouse.find_child("HP Percent")
@onready var starting_size = follow_percent.size.x
@onready var follow_text = follow_mouse.find_child("Label")
@onready var filter:ColorRect = filter_root.find_child("Filter")
@onready var root = get_parent_node_3d().get_parent_node_3d().get_parent_node_3d()
@onready var game:GameManager = root.find_child("GameManager")
@onready var wave:WaveManager = game.request_manager(GameManager.MANAGERS.WAVE)
@onready var registry:TowerRegistry = game.request_manager(game.MANAGERS.REGISTRY)
@onready var money:MoneyManager = game.request_manager(game.MANAGERS.MONEY)
var can_place_color = Color(1.0,1.0,1.0,0.16)
var can_not_place_color = Color(1.0,0.0,0.08,0.16)
var place_holder_tower
var current_selected = 0
var placeholder_visible = false
var deny_placement = false
var placeholder_position:Vector3
var placed_tower = false
var inspecting_tower = false
var inspected_tower
var game_ended = false
func _ready():
	follow_mouse.resized.connect(func ():
		starting_size = follow_percent.size.x
	)
	wave.beat_game.connect(game_end)
func game_end():
	revoke_placeholder()
	registry.hide_all_tower_deny()
	game_ended = true
func set_filter(color:Color):
	filter.color = color
func show_filter():
	filter.visible = true
func hide_filter():
	filter.visible = false
func get_placeholder(idx):
	revoke_placeholder()
	show_filter()
	print("showing?")
	registry.show_all_tower_deny()
	var tower_selected = registry.get_tower(idx)
	place_holder_tower = tower_selected.instantiate()
	place_holder_tower.is_placeholder = true
	current_selected = idx
	root.add_child(place_holder_tower)
	place_holder_tower.show_range()
	move_tower_to_mouse()
func revoke_placeholder():
	if !place_holder_tower: return
	hide_filter()
	current_selected = false
	deny_placement = false
	place_holder_tower.queue_free()
	place_holder_tower = false
func _unhandled_input(event):
	handle_rotate(event)
	if game_ended: return
	handle_cast(event)
	handle_move(event)
	handle_tower_select(event)
	handle_cancel(event)
	handle_tower_pick(event)
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
	if deny_placement: return
	if !place_holder_tower: return
	if event.is_action_released("pick"):
		var test_tower = registry.get_tower(current_selected).instantiate()
		var can_buy = money.request_purchase(test_tower.cost)
		if !can_buy: return
		registry.place_tower(current_selected,placeholder_position)
		revoke_placeholder()
		placed_tower = true
func handle_move(event):
	if !place_holder_tower: return
	if !event is InputEventMouseMotion: return
	move_tower_to_mouse()
func move_tower_to_mouse():
	var result = cast()
	if !result:
		deny_placement = true
		return
	if result['collider'].is_in_group("path"):
		set_filter(can_not_place_color)
		deny_placement = true
	else:
		set_filter(can_place_color)
		deny_placement = false
	if place_holder_tower.check_deny():
		set_filter(can_not_place_color)
		deny_placement = true
	place_holder_tower.set_position(result['position'])
	placeholder_position = result['position']
func handle_tower_select(event):
	if event.is_action_released("select1"):
		get_placeholder(0)
	elif event.is_action_released("select2"):
		get_placeholder(1)
	elif event.is_action_released("select3"):
		get_placeholder(2)
	elif event.is_action_released("select4"):
		get_placeholder(3)
	elif event.is_action_released("select5"):
		get_placeholder(4)
func handle_cancel(event):
	if !event.is_action_released("cancel"): return
	revoke_placeholder()
	registry.hide_all_tower_deny()
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
				tower_stats.remove_tower_stuff()
				tower_stats.hide()
				inspected_tower.hide_all()
				inspecting_tower = false
				inspected_tower = false
			return
		if result['collider'].name != "TowerCollider":
			return
		if inspected_tower:
			inspected_tower.hide_all()
		var parent:Tower = result['collider'].get_parent_node_3d()
		parent.show_all()
		tower_stats.show()
		tower_stats.set_up_for_tower(parent)
		inspecting_tower = true
		inspected_tower = parent


func enemy_pick():
	var result = cast(8)
	if !result: 
		follow_mouse.visible = false
		return
	follow_mouse.visible = true
	follow_mouse.position = get_viewport().get_mouse_position()
	var entity = result['collider'].get_parent_node_3d()
	follow_text.text = str(entity.hp) + "/" + str(entity.max_hp)
	var percent:float = float(entity.hp) / float(entity.max_hp)
	var new_size = starting_size * percent
	follow_percent.size.x = new_size
@onready var center_parent2 = get_parent_node_3d()
@onready var center_parent = center_parent2.get_parent_node_3d()
@export var SENSITIVITY = 0.001
func handle_rotate(event):
	if !event is InputEventMouseMotion: return
	if !Input.is_action_pressed("rotate"): return
	center_parent.rotate_y(event.relative.x * -SENSITIVITY)
	center_parent2.rotate_x(event.relative.y * -SENSITIVITY)
	center_parent2.rotation.x = clampf(center_parent2.rotation.x,-PI/4,17/(180/PI))
func _process(_delta):
	enemy_pick()
