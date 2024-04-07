extends Node
class_name TimeScale
@export var time_scale:float = 1:
	set = set_time_scale
signal scale_changed()
func set_time_scale(val):
	time_scale = val
	scale_changed.emit()
func get_time_scale():
	return time_scale
func mult(val):
	var new_val = val * time_scale
	return new_val
func div(val):
	var new_val = val/time_scale
	return new_val


func _on_time_scale_time_scale_changed(val):
	time_scale = val
