extends Node
class_name TimeScale
@export var time_scale:float = 1
func set_time_scale(val):
	time_scale = val
func get_time_scale():
	return time_scale
func mult(val):
	var new_val = val * time_scale
	return new_val
func div(val):
	var new_val = val/time_scale
	return new_val
