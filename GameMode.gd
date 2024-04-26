@tool
extends Resource
class_name GameMode
@export var waves:Array[Wave]
func unpack_waves():
	var waves_array = []
	var children = waves
	for x in len(children):
		var wave_return = []
		var child = waves[x]
		var enemies = child.enemies
		wave_return.resize(enemies.size())
		var times = child.times
		var wave_delay = child.delay
		var wave_bonus = child.bonus
		var wave_message = child.message
		for y in len(enemies):
			wave_return[y] = {
				"type": enemies[y],
				"delay": times[y],
			}
		var return_item = {
			"wave": wave_return,
			"delay": wave_delay,
			"bonus": wave_bonus,
			"message": wave_message,
		}
		waves_array.append(return_item)
	return waves_array
