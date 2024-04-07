extends Control
@export var text:Label
signal time_scale_changed(val)
func _ready():
	text.speed_change.connect(emit_thing)
func emit_thing(val):
	time_scale_changed.emit(val)
