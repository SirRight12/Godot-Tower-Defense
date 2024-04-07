extends Label
signal speed_change(val)
@export var speeds: Array[float]
var current_val = 0
func get_next_speed():
	print(current_val)
	if current_val + 1 >= speeds.size():
		current_val = -1
	current_val += 1
	var return_speed = speeds[current_val]
	speed_change.emit(return_speed)
	return return_speed


func _on_texture_button_pressed():
	var speed = get_next_speed()
	set_text(str(speed) + "x")
	
