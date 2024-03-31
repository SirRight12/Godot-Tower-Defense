extends Label

func _on_h_slider_value_changed(value):
	set_text(str(value) + "x")
