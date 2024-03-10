extends Node3D
class_name PathEntity
@export_subgroup("stats")
@export var speed:float = 1.0
@export var provide_path: PathFollow3D
signal achieved_goal()
var path:PathFollow3D
var reached_goal = false
@export var progress = 0.0
@export var provide_scaler:TimeScale
var scaler
func get_path_follower():
	if !path:
		return get_parent_node_3d().find_child("Path").find_child("Follow")
	return path
func get_time_scaler():
	if !provide_scaler:
		return get_parent_node_3d().find_child("TimeScaleManager") 
	return provide_scaler
func move_self(dt):
	if reached_goal: return
	progress += speed * dt
	path.progress = progress
	set_position(path.get_position())
	set_rotation(path.get_rotation())
	check_goal()
func check_goal():
	if path.progress_ratio >= 1 and speed > 0:
		queue_free()
		_enter()
		achieved_goal.emit()
		reached_goal = true
		pass
	elif path.progress_ratio <= 0 and speed < 0:
		queue_free()
		reached_goal = true
		pass
func _enter_tree():
	path = get_path_follower()
	scaler = get_time_scaler()
	move_self(.001)
	_set_tag()
func _process(delta):
	var s_dt = scaler.mult(delta)
	move_self(s_dt)
 #functions for other classes to use
func _enter():
	pass
func _set_tag():
	pass
