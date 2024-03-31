extends Node
class_name FactionManager
@export var factions:Array[FactionStats]
var faction_stats = {}
func get_faction(faction:String):
	return faction_stats[faction]
func _ready():
	for x in len(factions):
		
		var faction:FactionStats = factions[x]
		faction_stats[faction.name] = {}
		faction_stats[faction.name]['ASB'] = faction.attack_speed_boost
		faction_stats[faction.name]['ASN'] = faction.AS_negative
		faction_stats[faction.name]['DB'] = faction.damage_boost
		faction_stats[faction.name]['DN'] = faction.D_negative
		faction_stats[faction.name]['IB'] = faction.income_boost
		faction_stats[faction.name]['IN'] = faction.I_negative
	print(faction_stats)
