extends Sprite3D
@export var added_height = 2.0
@onready var original_pos = get_position() 
@onready var final_pos = original_pos + Vector3(0.0,added_height,0.0)
func tween_color(final:Color,duration):
	$SubViewport/Label.self_modulate = Color(1.0,1.0,1.0)
	create_tween().tween_property($SubViewport/Label,"self_modulate",final,duration)
func tween_pos(final,duration):
	set_position(original_pos)
	var tween = create_tween().tween_property(self,"position",final,duration)
	return tween
func recieved_money(amt:int,scaler:TimeScale):
	$SubViewport/Label.set_text("+$"+str(amt))
	show()
	tween_color(Color(1.0,1.0,1.0,0.0),scaler.div(1))
	var pos_tween = tween_pos(final_pos,scaler.div(1))
	await pos_tween.finished
	hide()
