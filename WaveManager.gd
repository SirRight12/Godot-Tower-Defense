extends Node
class_name WaveManager
@export var current_game_mode:GameMode
@export var basic:PackedScene
@export var speedy:PackedScene
@export var zickey: PackedScene
@onready var enemy_types:Array[PackedScene] = [basic,speedy,zickey]
@onready var parent:Node3D = get_parent().get_parent()
@onready var game:GameManager = get_parent()
@onready var base:Base = game.request_manager(game.MANAGERS.BASE)
@onready var money:MoneyManager = game.request_manager(game.MANAGERS.MONEY)
@onready var wave_text = game.request_manager(game.MANAGERS.WAVETEXT)
@onready var start_node = $"../Start"
@onready var start_button = $"../Start/Button"
var time_scale_manager:TimeScale
var current_wave = 0
signal wave_end()
signal beat_game()
var waves:Array
var enemies_left
func clear_text():
	await timeout(.3)
	wave_text.clear()
	
func _ready():
	time_scale_manager = get_parent().find_child("TimeScaleManager")
	await start_button.pressed
	start_node.queue_free()
	start_waves()
	wave_text.text_done.connect(clear_text)
func start_waves():
	waves = current_game_mode.unpack_waves()
	start_wave(current_wave)
func start_wave(idx):
	if waves.size() == idx: 
		beat_game.emit()
		return
	var wave_data = waves[idx]
	var wave = wave_data['wave']
	money.add(wave_data['bonus'])
	print("Begin ",wave_data," HI")
	if wave_data['message']:
		wave_text.cool_text(wave_data['message'])
	wave_end.emit()
	await timeout(time_scale_manager.div(wave_data['delay']))
	enemies_left = wave.size()
	for x in len(wave):
		var enemy_data = wave[x]
		var type = enemy_data["type"]
		var delay = enemy_data["delay"]
		await timeout(time_scale_manager.div(delay),true)
		var spawned_enemy = enemy_types[type].instantiate()
		spawned_enemy.died.connect(enemy_die)
		parent.add_child(spawned_enemy)
func check_wave_over():
	if enemies_left <= 0:
		current_wave += 1
		start_wave(current_wave)
func enemy_die():
	enemies_left -= 1
	check_wave_over()
func timeout(time,mil=false):
	if mil:
		time = time/1000
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return true
