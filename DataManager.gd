extends Node
class_name GameDataManager
var json_data:Dictionary = JSON.parse_string(FileAccess.open("res://test.json",FileAccess.READ).get_as_text())
func write(val):
	json_data = val
	print(val)
	var actual_data = JSON.stringify(json_data)
	var file = FileAccess.open("res://test.json",FileAccess.WRITE)
	file.store_string(actual_data)
	file.close()
func _ready():
	print(json_data)
	if !json_data['faction']:
		json_data['faction'] = 'none'
	#test (comment later)
	#json_data['faction'] = "mercenaries"
