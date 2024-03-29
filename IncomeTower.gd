extends Tower
class_name IncomeTower
@export var income:int = 100:
	get = apply_income_buffs
func apply_income_buffs():
	var i = income
	#for now do nothing
	return i
func _ready():
	entity.idle()
	wave.wave_end.connect(generate_income)
func generate_income():
	money.add(income)
func _init():
	pass
