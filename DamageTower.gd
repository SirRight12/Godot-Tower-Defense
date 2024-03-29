@icon("res://Tower.svg")
extends Tower
class_name DamageTower
func _init():
	assert(false,"DamageTower is an abstract class, try using GunTower")
@export var damage:int = 1:
	get = get_damage
@export var reload_time:float = 1:
	get = get_reload_time
@export var money_bonus:float = 1.0
var awaiting_attack = false
func _process(_delta):
	if is_placeholder: return
	if awaiting_attack: return
	if range_util.areas.size() < 1: return
	awaiting_attack = true
	var target = range_util.get_first_target()
	entity.look_at(target.position)
	entity.rotation.x = 0
	entity.rotation.z = 0
	_shoot(target)
	await timeout(reload_time)
	awaiting_attack = false
	pass
func timeout(time):
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return true
func _shoot(_enemy):
	pass
func get_damage():
# for messing around with buffs
	var damage_changed = damage
	return damage_changed
func get_reload_time():
# for messing around with buffs
	var time_changed = reload_time
	time_changed = scaler.div(time_changed)
	return time_changed
