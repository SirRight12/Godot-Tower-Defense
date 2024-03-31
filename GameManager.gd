extends Node
class_name GameManager
enum MANAGERS{WAVE,BASE,TIMESCALE,REGISTRY,MONEY,DATA,FACTIONS}
func request_manager(type:MANAGERS) -> Node:
	match (type):
		0:
			#wave
			return $WaveManager
		1:
			#base
			return $Base
		2:
			#timescale
			return $TimeScaleManager
		3:
			#Registry
			return $TowerRegistry
		4:
			#Money
			return $MoneyManager
		5:
			#Data
			return $DataManager
		6:
			#Factions
			return $FactionManager
	# Default
	return Node.new()
