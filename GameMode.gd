extends Node
class_name GameMode
@export var waves:Array[Wave]
func unpack_waves():
	var waves_array = []
	for x in len(waves):
		var wave_return = []
		var wave = waves[x]
		var enemies = wave.enemies
		wave_return.resize(enemies.size())
		var times = wave.times
		for y in len(enemies):
			wave_return[y] = {
				"type": enemies[y],
				"delay": times[y],
			}
		waves_array.append(wave_return)
	return waves_array
