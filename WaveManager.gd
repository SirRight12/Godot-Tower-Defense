extends Node
class_name WaveManager
@export var current_game_mode:GameMode
@export var basic:PackedScene
@export var speedy:PackedScene
@onready var enemy_types:Array[PackedScene] = [basic,speedy]
var time_scale_manager:TimeScale
var current_wave = 0
var waves:Array
var enemies_left
func _ready():
	#remove later
	time_scale_manager = get_parent().find_child("TimeScaleManager")
	start_waves()
func start_waves():
	waves = current_game_mode.unpack_waves()
	start_wave(current_wave)
func start_wave(idx):
	var parent = get_parent()
	var wave = waves[idx]
	enemies_left = wave.size()
	for x in len(wave):
		var enemy_data = wave[x]
		var type = enemy_data["type"]
		var delay = enemy_data["delay"]
		await timeout(time_scale_manager.div(delay),true)
		var spawned_enemy = enemy_types[type].instantiate()
		spawned_enemy.achieved_goal.connect(enemy_die)
		parent.call_deferred("add_child",spawned_enemy)
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
