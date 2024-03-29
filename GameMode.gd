@tool
extends Resource
class_name GameMode
@export var test:bool:
	set = set_test
func set_test(_val):
	test = false
	#print(unpack_waves())
@export var waves:Array[Wave]
func unpack_waves():
	var waves_array = []
	var children = waves
	for x in len(children):
		var wave_return = []
		var child = waves[x]
		print(child.enemies)
		var enemies = child.enemies
		print(enemies.size())
		wave_return.resize(enemies.size())
		var times = child.times
		var wave_delay = child.delay
		var wave_bonus = child.bonus
		for y in len(enemies):
			wave_return[y] = {
				"type": enemies[y],
				"delay": times[y],
			}
		var return_item = {
			"wave": wave_return,
			"delay": wave_delay,
			"bonus": wave_bonus,
		}
		waves_array.append(return_item)
	return waves_array
