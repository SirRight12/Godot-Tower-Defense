extends Tower
class_name IncomeTower
@export var income:int = 100:
	get = apply_income_buffs
func apply_income_buffs():
	var i = income
	#for now do nothing
	return i
func _ready():
	time_scale_change()
	entity.idle()
	scaler.scale_changed.connect(time_scale_change)
	if is_placeholder: return
	wave.wave_end.connect(generate_income)
	wave.beat_game.connect(dance)
func generate_income():
	money.add(income)
	$IncomeText.recieved_money(income,scaler)
func _init():
	pass
func apply_upgrade(upgrade_to_apply:Upgrade):
	apply_regular_upgrade(upgrade_to_apply)
	apply_income_upgrade(upgrade_to_apply)
func apply_income_upgrade(upgrade_to_apply:IncomeTowerUpgrade):
	income += upgrade_to_apply.income
