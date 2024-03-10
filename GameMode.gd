extends Node
class_name GameMode
func unpack_waves():
	var waves_array = []
	var children = get_children()
	for x in len(children):
		var wave = []
		var child = children[x]
		var enemies = child.enemies
		wave.resize(enemies.size())
		var times = child.times
		for y in len(enemies):
			wave[y] = {
				"type": enemies[y],
				"delay": times[y],
			}
		waves_array.append(wave)
	return waves_array
