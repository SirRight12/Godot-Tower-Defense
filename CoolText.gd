extends Control

@onready var text_node = $Node/SubViewport/Label
var test_text = "Get ready, this one won't be easy (probably)"
var text_delay = 1
signal text_done()
func timeout(time):
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return true
func _ready():
	cool_text(test_text)
	text_done.connect(_on_text_done)
	pass
func cool_text(text):
	text_node.text = ""
	cool_text_loop(text,0)
func cool_text_loop(text:String,current_letter:int):
	text_node.text += text[current_letter]
	current_letter += 1
	await timeout(.05)
	if len(text) <= current_letter:
		text_done.emit()
		return
	cool_text_loop(text,current_letter)	
func _on_text_done():
	cool_text(test_text)
	
	
