extends Node
class_name GameManager
enum MANAGERS{WAVE,BASE,TIMESCALE,EASY,REGISTRY,MONEY}
func request_manager(type:MANAGERS):
	match (type):
		0:
			#wave
			return find_child("WaveManager")
		1:
			#base
			return find_child("Base")
		2:
			#timescale
			return find_child("TimeScaleManager")
		3:
			#easy mode
			return find_child("Easy")
		4:
			#Registry
			return find_child("TowerRegistry")
		5:
			#Money
			return find_child("MoneyManager")
