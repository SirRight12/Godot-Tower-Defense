extends Node3D
class_name PathEntity
@export var speed:float = 1.0
@export var provide_path: PathFollow3D
signal died()
var path:PathFollow3D
var reached_goal = false
@export var progress = 0.0

@onready var game:GameManager = get_parent_node_3d().find_child("GameManager")
@onready var scaler:TimeScale = game.request_manager(game.MANAGERS.TIMESCALE)
func get_path_follower():
	if !path:
		return get_parent_node_3d().find_child("Path").find_child("Follow")
	return path
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
		died.emit()
		reached_goal = true
		pass
	elif path.progress_ratio <= 0 and speed < 0:
		queue_free()
		reached_goal = true
		pass
func _ready():
	path = get_path_follower()
	move_self(.001)
func _process(delta):
	var s_dt = scaler.mult(delta)
	move_self(s_dt)
#functions for other classes to use
func _enter():
	pass
