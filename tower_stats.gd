extends Control
@onready var tower_container = $Tower/Container/SV
@onready var stats_text = $Node/SubViewport/Label
@export var tower_dictionary:Dictionary
@onready var buy_button:Button = $BuyUpgrade
@onready var game:GameManager = get_parent().find_child("GameManager")
@onready var money:MoneyManager = game.request_manager(game.MANAGERS.MONEY)
var current_tower
func set_up_for_tower(tower:Tower):
	print("set up")
	var tower_name = tower.tower_name
	var viewport_scene = tower_dictionary[tower_name]
	remove_tower_stuff()
	current_tower = tower
	var viewport_tower = viewport_scene.instantiate()
	tower_container.add_child(viewport_tower)
	if tower.upgrade + 1 >= tower.upgrades.size():
		stats_text.set_text("MAX UPGRADE\n" + max_upgrade_text(tower))
		return
	var upgrade:Upgrade = tower.upgrades[tower.upgrade + 1]
	var cost_text = "Cost: $" + str(upgrade.cost) + "\n"
	var range_text = "Range: " + str(tower.tower_range) + "-->" + str(tower.tower_range + upgrade.upgrade_range) + '\n'
	buy_button.pressed.connect(buy_upgrade)
	if upgrade is DamageTowerUpgrade:
		var damage_text = "Damage: " + str(tower.damage) + "-->" + str(tower.damage + upgrade.damage) + '\n'
		var attack_speed_text = "Attack Speed: " + str(tower.reload_time) + "-->" + str(tower.reload_time - upgrade.attack_speed) + '\n'
		
		stats_text.set_text(cost_text + damage_text + attack_speed_text + range_text)
	elif upgrade is IncomeTowerUpgrade:
		var income_text = "Income: $" + str(tower.income) + "-->$" + str(tower.income + upgrade.income)
		stats_text.set_text(cost_text + range_text + income_text)
func remove_tower_stuff():
	var children = tower_container.get_children()
	current_tower = false
	for x in children.size():
		var child = children[x]
		child.queue_free()
func buy_upgrade():
	buy_button.pressed.disconnect(buy_upgrade)
	current_tower.upgrade += 1
	var upgrade:Upgrade = current_tower.upgrades[current_tower.upgrade]
	var request = money.request_purchase(upgrade.cost)
	if !request: return
	print("hello? bought")
	current_tower.apply_upgrade(upgrade)
	set_up_for_tower(current_tower)
func max_upgrade_text(tower:Tower):
	var range_text = "Range: " + str(tower.tower_range) + '\n'
	if tower is DamageTower:
		var damage_text = "Damage: " + str(tower.damage) + '\n'
		var attack_speed_text = "Attack Speed: " + str(tower.reload_time) + '\n'
		return damage_text + attack_speed_text + range_text
	elif tower is IncomeTower:
		var income_text = "Income: " + str(tower.income) + '\n'
		return range_text + income_text
	
