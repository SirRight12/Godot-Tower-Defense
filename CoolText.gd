extends Control

@onready var text_node = $Node/SubViewport/Label
@onready var game:GameManager = $".."
@onready var time_scale:TimeScale = game.request_manager(game.MANAGERS.TIMESCALE)
var text_delay = 1
signal text_done()
func clear():
	text_node.text = ""
func timeout(time):
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return true
func cool_text(text):
	text_node.text = ""
	cool_text_loop(text,0)
func cool_text_loop(text:String,current_letter:int):
	text_node.text += text[current_letter]
	current_letter += 1
	await timeout(time_scale.div(.05))
	if len(text) <= current_letter:
		text_done.emit()
		return
	cool_text_loop(text,current_letter)
	
